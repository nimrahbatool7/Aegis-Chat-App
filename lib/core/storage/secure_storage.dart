// lib/core/storage/secure_storage.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage() : _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Auth Token
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: AppConfig.authTokenKey, value: token);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: AppConfig.authTokenKey);
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: AppConfig.authTokenKey);
  }

  // User ID
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: AppConfig.userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: AppConfig.userIdKey);
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: AppConfig.userIdKey);
  }

  // Encryption Keys
  Future<void> savePrivateKey(String key) async {
    await _storage.write(key: 'private_key', value: key);
  }

  Future<String?> getPrivateKey() async {
    return await _storage.read(key: 'private_key');
  }

  Future<void> savePublicKey(String key) async {
    await _storage.write(key: 'public_key', value: key);
  }

  Future<String?> getPublicKey() async {
    return await _storage.read(key: 'public_key');
  }

  // Clear All Data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Generic Save/Read
  Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
