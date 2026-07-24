import '../../../core/network/api_exception.dart';
import '../../../core/storage/token_storage.dart';
import 'auth_api.dart';
import 'models/app_user.dart';

class AuthRepository {
  const AuthRepository(this._api, this._tokenStorage);

  final AuthApi _api;
  final TokenStorage _tokenStorage;

  Future<AppUser> login({required String email, required String password}) async {
    final response = await _api.login(email: email, password: password);

    if (!response.user.isResident && !response.user.isGuard) {
      throw const ApiException(message: 'This account does not have access to this app.');
    }

    await _tokenStorage.saveTokens(
      accessToken: response.accessToken,
      accessTokenExpiresAtUtc: response.accessTokenExpiresAtUtc,
      refreshToken: response.refreshToken,
      refreshTokenExpiresAtUtc: response.refreshTokenExpiresAtUtc,
    );
    return response.user;
  }

  Future<String> register({required String fullName, required String email, required String password}) {
    return _api.register(fullName: fullName, email: email, password: password);
  }

  /// Returns the current user if a still-valid refresh token is stored,
  /// otherwise clears any stale tokens and returns null. Fetching `/auth/me`
  /// transparently rotates an expired access token via [ApiClient]'s
  /// refresh interceptor.
  Future<AppUser?> restoreSession() async {
    if (!await _tokenStorage.hasValidRefreshToken()) {
      await _tokenStorage.clear();
      return null;
    }

    try {
      final user = await _api.getCurrentUser();
      if (!user.isResident && !user.isGuard) {
        await _tokenStorage.clear();
        return null;
      }
      return user;
    } on ApiException {
      await _tokenStorage.clear();
      return null;
    }
  }

  Future<void> logout() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    await _tokenStorage.clear();
    if (refreshToken != null) {
      try {
        await _api.logout(refreshToken);
      } on ApiException {
        // Already signed out locally; server-side revoke failing is not fatal.
      }
    }
  }
}
