import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // final _storage = const FlutterSecureStorage();
  final Map<String, String> _storage = {};
  final String _accessTokenKey = "accessToken";

  Future<void> setAccessToken(String accessToken) async {
    try {
      // await _storage.write(key: _accessTokenKey, value: accessToken);
      _storage[_accessTokenKey] = accessToken;
      log("Token saved securely: $accessToken");
    } catch (e) {
      log("Error saving token: $e");
    }
  }

  Future<String?> getAccessToken() async {
    try {
      // return await _storage.read(key: _accessTokenKey);
      return _storage[_accessTokenKey];
    } catch (e) {
      log("Error retrieving token: $e");
      return null;
    }
  }

  Future<void> clearStorage() async {
    try {
      // await _storage.deleteAll();
      _storage.clear();
      log("Storage cleared successfully!");
    } catch (e) {
      log("Error clearing storage: $e");
    }
  }

  final String _refreshTokenKey = "refreshToken";

  Future<void> setRefreshToken(String refreshToken) async {
    try {
      // await _storage.write(key: _refreshTokenKey, value: refreshToken);
      _storage[_refreshTokenKey] = refreshToken;
      log("Refresh token saved securely: $refreshToken");
    } catch (e) {
      log("Error saving refresh token: $e");
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      // return await _storage.read(key: _refreshTokenKey);
      return _storage[_refreshTokenKey];
    } catch (e) {
      log("Error retrieving refresh token: $e");
      return null;
    }
  }
}
