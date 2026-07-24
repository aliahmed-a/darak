import '../../../core/network/api_client.dart';
import 'models/app_user.dart';
import 'models/auth_response.dart';

/// Raw calls against `DARAK.Api`'s `/api/auth` endpoints.
class AuthApi {
  const AuthApi(this._client);

  final ApiClient _client;

  Future<AuthResponse> login({required String email, required String password}) => runApiCall(() async {
        final response = await _client.dio.post('/auth/login', data: {
          'email': email,
          'password': password,
        });
        return AuthResponse.fromJson(response.data as Map<String, dynamic>);
      });

  /// Returns the server's confirmation message (registration is `202
  /// Accepted`, not a token response — the account may need confirmation
  /// before it can log in).
  Future<String> register({required String fullName, required String email, required String password}) =>
      runApiCall(() async {
        final response = await _client.dio.post('/auth/register', data: {
          'fullName': fullName,
          'email': email,
          'password': password,
        });
        final data = response.data as Map<String, dynamic>;
        return data['message'] as String? ?? 'Registration received.';
      });

  Future<void> logout(String refreshToken) => runApiCall(() async {
        await _client.dio.post('/auth/logout', data: {'refreshToken': refreshToken});
      });

  Future<AppUser> getCurrentUser() => runApiCall(() async {
        final response = await _client.dio.get('/auth/me');
        return AppUser.fromJson(response.data as Map<String, dynamic>);
      });
}
