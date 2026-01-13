// lib/core/constants/app_constants.dart

class AppConstants {
  // Route Names
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String otpVerificationRoute = '/otp-verification';
  static const String chatListRoute = '/chat-list';
  static const String chatRoute = '/chat';
  static const String contactsRoute = '/contacts';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static const String privacySettingsRoute = '/privacy-settings';
  static const String activeDevicesRoute = '/active-devices';
  static const String sessionExpiredRoute = '/session-expired';
  static const String adminDashboardRoute = '/admin-dashboard';
  static const String userManagementRoute = '/user-management';
  static const String systemHealthRoute = '/system-health';
  static const String mlAnalyticsRoute = '/ml-analytics';
  static const String activitySummaryRoute = '/activity-summary';
  static const String threatWarningRoute = '/threat-warning';
  static const String mediaPreviewRoute = '/media-preview';
  static const String contactProfileRoute = '/contact-profile';
  
  // User Roles
  static const String roleUser = 'user';
  static const String roleAdmin = 'admin';
  static const String roleSuperAdmin = 'super_admin';
  static const String roleModerator = 'moderator';
  
  // Message Types
  static const String messageTypeText = 'text';
  static const String messageTypeImage = 'image';
  static const String messageTypeVideo = 'video';
  static const String messageTypeAudio = 'audio';
  static const String messageTypeDocument = 'document';
  static const String messageTypeLocation = 'location';
  
  // Threat Types
  static const String threatTypeMalware = 'malware';
  static const String threatTypePhishing = 'phishing';
  static const String threatTypeHarmfulLink = 'harmful_link';
  
  // Validation
  static const int minPasswordLength = 8;
  static const int otpLength = 6;
  static const int maxMessageLength = 5000;
}
