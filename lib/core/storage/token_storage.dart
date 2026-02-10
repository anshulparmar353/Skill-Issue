import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {

  final _storage = const FlutterSecureStorage();

  static const _accessToken = "ACCESS_TOKEN";
  static const _refreshToken = "REFRESH_TOKEN";

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _accessToken, value: access);
    await _storage.write(key: _refreshToken, value: refresh);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
