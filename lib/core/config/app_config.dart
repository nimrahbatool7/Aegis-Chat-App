// lib/core/config/app_config.dart

class AppConfig {
  static const String appName = 'Aegis Chat';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.aegischat.com/v1',
  );
  
  // Security Configuration
  static const bool enableEncryption = true;
  static const bool enableBiometric = true;
  
  // App Configuration
  static const int messagePageSize = 50;
  static const int maxFileSize = 100 * 1024 * 1024; // 100MB
  static const Duration sessionTimeout = Duration(hours: 24);
  static const Duration otpTimeout = Duration(minutes: 5);
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
}
