// lib/core/storage/local_storage.dart

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme Mode
  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString('theme_mode', mode);
  }

  String? getThemeMode() {
    return _prefs.getString('theme_mode');
  }

  // Settings
  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Clear All
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  // Remove specific key
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
