// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Core
import 'core/config/app_config.dart';
import 'core/constants/app_constants.dart';
import 'core/network/api_client.dart';
import 'core/storage/secure_storage.dart';
import 'core/storage/local_storage.dart';
import 'core/security/encryption_service.dart';

// Data
import 'data/repositories/auth_repository.dart';
import 'data/repositories/mock_auth_repository.dart';

// Presentation
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/register_screen.dart';
import 'presentation/screens/auth/otp_verification_screen.dart';

// Screens (old imports - will be refactored)
import 'screens/chat_list_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/active_devices_screen.dart';
import 'screens/session_expired_screen.dart';
import 'screens/contact_profile_screen.dart';
import 'screens/incoming_threat_warning.dart';
import 'screens/media_preview_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/user_management_screen.dart';
import 'screens/system_health_screen.dart';
import 'screens/ml_analytics_screen.dart';
import 'screens/activity_summary_screen.dart';
import 'screens/user_details_screen.dart';

// Models
import 'models/chat_model.dart';
import 'models/contact_model.dart';
import 'models/threat_model.dart';

// Utils
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize core services
  final secureStorage = SecureStorage();
  final localStorage = LocalStorage();
  await localStorage.init();

  final apiClient = ApiClient(secureStorage);
  final encryptionService = EncryptionService();

  // 🔧 MOCK MODE: Using MockAuthRepository for testing without backend
  // To use real backend, replace MockAuthRepository with AuthRepository
  // and update the API base URL in app_config.dart
  
  // Initialize mock repository (for testing)
  final authRepository = MockAuthRepository(
    secureStorage: secureStorage,
    localStorage: localStorage,
  );

  // Uncomment below to use real backend:
  // final authRepository = AuthRepository(
  //   apiClient: apiClient,
  //   secureStorage: secureStorage,
  //   localStorage: localStorage,
  // );

  runApp(MyApp(
    authRepository: authRepository,
    localStorage: localStorage,
  ));
}

class MyApp extends StatelessWidget {
  final dynamic authRepository; // Can be AuthRepository or MockAuthRepository
  final LocalStorage localStorage;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.localStorage,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(localStorage: localStorage),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            onGenerateRoute: _generateRoute,
          );
        },
      ),
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      // Auth Routes
      case AppConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppConstants.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case AppConstants.otpVerificationRoute:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(phoneNumber: phoneNumber),
        );

      // Main App Routes
      case AppConstants.chatListRoute:
        return MaterialPageRoute(builder: (_) => const ChatListScreen());

      case '/chat':
        final chat = settings.arguments as ChatModel;
        return MaterialPageRoute(builder: (_) => ChatScreen(chat: chat));

      case AppConstants.contactsRoute:
        return MaterialPageRoute(builder: (_) => const ContactsScreen());

      case AppConstants.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppConstants.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppConstants.privacySettingsRoute:
        return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());

      case AppConstants.activeDevicesRoute:
        return MaterialPageRoute(builder: (_) => const ActiveDevicesScreen());

      case AppConstants.sessionExpiredRoute:
        return MaterialPageRoute(builder: (_) => const SessionExpiredScreen());

      // Contact Profile
      case '/contact-profile':
        final contact = settings.arguments as ContactModel;
        return MaterialPageRoute(
          builder: (_) => ContactProfileScreen(contact: contact),
        );

      // Security Routes
      case AppConstants.threatWarningRoute:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => IncomingThreatWarning(
            threatType: args['type'] == 'harmfulLink'
                ? ThreatType.harmfulLink
                : ThreatType.malwareFile,
            fileName: args['fileName'] ?? 'Unknown File',
            fileSize: args['fileSize'] ?? 'Unknown Size',
            threatDescription: args['description'] ?? 'Security threat detected',
            linkUrl: args['linkUrl'],
            senderName: args['senderName'] ?? 'Unknown Sender',
          ),
        );

      case AppConstants.mediaPreviewRoute:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => MediaPreviewScreen(
            attachmentType: args['type'] ?? 'document',
            filePath: args['filePath'] ?? 'path/to/file.pdf',
            caption: args['caption'],
          ),
        );

      // Admin Routes (Protected)
      case AppConstants.adminDashboardRoute:
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());

      case AppConstants.userManagementRoute:
        return MaterialPageRoute(builder: (_) => const UserManagementScreen());

      case AppConstants.systemHealthRoute:
        return MaterialPageRoute(builder: (_) => const SystemHealthScreen());

      case AppConstants.mlAnalyticsRoute:
        return MaterialPageRoute(builder: (_) => const MLAnalyticsScreen());

      case AppConstants.activitySummaryRoute:
        return MaterialPageRoute(builder: (_) => const ActivitySummaryScreen());

      case '/user-details':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => UserDetailsScreen(userData: args),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }
}

