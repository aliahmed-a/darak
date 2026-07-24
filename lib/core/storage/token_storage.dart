import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'access_token';
  static const _accessTokenExpiryKey = 'access_token_expiry_utc';
  static const _refreshTokenKey = 'refresh_token';
  static const _refreshTokenExpiryKey = 'refresh_token_expiry_utc';

  Future<void> saveTokens({
    required String accessToken,
    required DateTime accessTokenExpiresAtUtc,
    required String refreshToken,
    required DateTime refreshTokenExpiresAtUtc,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _accessTokenExpiryKey, value: accessTokenExpiresAtUtc.toIso8601String()),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _refreshTokenExpiryKey, value: refreshTokenExpiresAtUtc.toIso8601String()),
    ]);
  }

  Future<String?> readAccessToken() => _storage.read(key: _accessTokenKey);

  Future<String?> readRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<DateTime?> _readAccessTokenExpiryUtc() async {
    final value = await _storage.read(key: _accessTokenExpiryKey);
    return value == null ? null : DateTime.tryParse(value);
  }

  Future<DateTime?> readRefreshTokenExpiryUtc() async {
    final value = await _storage.read(key: _refreshTokenExpiryKey);
    return value == null ? null : DateTime.tryParse(value);
  }

  Future<bool> hasValidAccessToken() async {
    final token = await readAccessToken();
    if (token == null) return false;

    final expiry = await _readAccessTokenExpiryUtc();
    return expiry != null && expiry.isAfter(DateTime.now().toUtc());
  }

  Future<bool> hasValidRefreshToken() async {
    final token = await readRefreshToken();
    if (token == null) return false;

    final expiry = await readRefreshTokenExpiryUtc();
    return expiry != null && expiry.isAfter(DateTime.now().toUtc());
  }

  Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _accessTokenExpiryKey),
      _storage.delete(key: _refreshTokenKey),
      _storage.delete(key: _refreshTokenExpiryKey),
    ]);
  }
}
