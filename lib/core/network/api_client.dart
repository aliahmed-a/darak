import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';

/// Wraps a [Dio] instance configured for `DARAK.Api`: attaches the bearer
/// access token to every request and transparently rotates it via
/// `POST /auth/refresh` on a 401, retrying the failed request once.
///
/// If the refresh token itself is invalid/expired, [onSessionExpired] fires
/// so the app can drop the user back to the login screen.
class ApiClient {
  ApiClient(this._tokenStorage)
      : dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenStorage.readAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          final isRefreshCall = error.requestOptions.path.endsWith('/auth/refresh');
          if (error.response?.statusCode != 401 || isRefreshCall) {
            handler.next(_mapError(error));
            return;
          }

          try {
            final newAccessToken = await _refreshAccessToken();
            final retryOptions = error.requestOptions;
            retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final response = await dio.fetch(retryOptions);
            handler.resolve(response);
          } catch (_) {
            await _tokenStorage.clear();
            onSessionExpired?.call();
            handler.next(_mapError(error, sessionExpired: true));
          }
        },
      ),
    );
  }

  final Dio dio;
  final TokenStorage _tokenStorage;

  /// Invoked when the refresh token is missing/expired/rejected by the
  /// server. Wired up by the auth feature so the router can react.
  void Function()? onSessionExpired;

  Future<String>? _pendingRefresh;

  Future<String> _refreshAccessToken() {
    return _pendingRefresh ??= _performRefresh().whenComplete(() => _pendingRefresh = null);
  }

  Future<String> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null) {
      throw const ApiException(message: 'No refresh token available.');
    }

    final refreshDio = Dio(BaseOptions(baseUrl: AppConfig.baseUrl));
    final response = await refreshDio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    final data = response.data as Map<String, dynamic>;

    final newAccessToken = data['accessToken'] as String;
    await _tokenStorage.saveTokens(
      accessToken: newAccessToken,
      accessTokenExpiresAtUtc: DateTime.parse(data['accessTokenExpiresAtUtc'] as String),
      refreshToken: data['refreshToken'] as String,
      refreshTokenExpiresAtUtc: DateTime.parse(data['refreshTokenExpiresAtUtc'] as String),
    );
    return newAccessToken;
  }

  DioException _mapError(DioException error, {bool sessionExpired = false}) {
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] is String) {
      return error.copyWith(
        error: ApiException(
          message: data['message'] as String,
          traceId: data['traceId'] as String?,
          statusCode: error.response?.statusCode,
          errors: (data['errors'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, List<String>.from(value as List)),
          ),
          sessionExpired: sessionExpired,
        ),
      );
    }

    return error.copyWith(
      error: ApiException(
        message: error.message ?? 'Something went wrong. Please try again.',
        statusCode: error.response?.statusCode,
        sessionExpired: sessionExpired,
      ),
    );
  }
}

/// Runs an API call, translating a failed [DioException] into the
/// [ApiException] produced by [ApiClient]'s error interceptor.
Future<T> runApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    if (e.error is ApiException) throw e.error as ApiException;
    throw ApiException(message: e.message ?? 'Something went wrong. Please try again.');
  }
}
