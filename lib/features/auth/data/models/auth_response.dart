import 'app_user.dart';

class AuthResponse {
  const AuthResponse({
    required this.accessToken,
    required this.accessTokenExpiresAtUtc,
    required this.refreshToken,
    required this.refreshTokenExpiresAtUtc,
    required this.user,
  });

  final String accessToken;
  final DateTime accessTokenExpiresAtUtc;
  final String refreshToken;
  final DateTime refreshTokenExpiresAtUtc;
  final AppUser user;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json['accessToken'] as String,
        accessTokenExpiresAtUtc: DateTime.parse(json['accessTokenExpiresAtUtc'] as String),
        refreshToken: json['refreshToken'] as String,
        refreshTokenExpiresAtUtc: DateTime.parse(json['refreshTokenExpiresAtUtc'] as String),
        user: AppUser.fromJson(json['user'] as Map<String, dynamic>),
      );
}
