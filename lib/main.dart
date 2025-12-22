// lib/main.dart
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/chat_list_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/verify_screen.dart';
import 'screens/incoming_threat_warning.dart';
import 'screens/media_preview_screen.dart';
import 'screens/test_threat_screen.dart';

import 'screens/user_profile_view_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/privacy_settings_screen.dart';
import 'screens/active_devices_screen.dart';
import 'screens/session_expired_screen.dart';
import 'screens/contact_profile_screen.dart';

import 'utils/constants.dart';
import 'models/threat_model.dart';
import 'models/contact_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aegis Chat',
      debugShowCheckedModeBanner: false,

      /// ---------------- LIGHT THEME ----------------
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryLight,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryLight,
          brightness: Brightness.light,
        ),
      ),

      /// ---------------- DARK THEME ----------------
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        cardTheme: CardTheme(
          color: AppColors.secondaryDark,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        dividerColor: AppColors.dividerDark,

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textPrimaryDark),
          bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
          titleLarge: TextStyle(color: AppColors.textPrimaryDark),
          titleMedium: TextStyle(color: AppColors.textPrimaryDark),
          titleSmall: TextStyle(color: AppColors.textSecondaryDark),
          labelLarge: TextStyle(color: AppColors.textPrimaryDark),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark,
          hintStyle: const TextStyle(color: AppColors.textDisabledDark),
          labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.accentGreen),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentGreen,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        listTileTheme: const ListTileThemeData(
          tileColor: AppColors.secondaryDark,
          iconColor: AppColors.textSecondaryDark,
          textColor: AppColors.textPrimaryDark,
        ),

        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentGreen,
          secondary: AppColors.accentBlue,
          background: AppColors.backgroundDark,
          surface: AppColors.surfaceDark,
        ),
      ),

      /// FORCE DARK MODE 
      themeMode: ThemeMode.dark,

      /// ---------------- ROUTING ----------------
      home: const LoginScreen(),
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.contacts: (_) => const ContactsScreen(),
        AppRoutes.chatList: (_) => const ChatListScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
        AppRoutes.verify: (_) =>
            const VerifyScreen(phoneNumber: '+92 300 1234567'),

        '/test-screens': (_) => const TestThreatScreen(),
        '/user-profile-view': (_) => const UserProfileViewScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/privacy-settings': (_) => const PrivacySettingsScreen(),
        '/active-devices': (_) => const ActiveDevicesScreen(),
        '/session-expired': (_) => const SessionExpiredScreen(),

        '/contact-profile': (context) {
          final contact =
              ModalRoute.of(context)!.settings.arguments as Contact;
          return ContactProfileScreen(contact: contact);
        },

        AppRoutes.threatWarning: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
                  {};
          return IncomingThreatWarning(
            threatType: args['type'] == 'harmfulLink'
                ? ThreatType.harmfulLink
                : ThreatType.malwareFile,
            fileName: args['fileName'] ?? 'Unknown File',
            fileSize: args['fileSize'] ?? 'Unknown Size',
            threatDescription:
                args['description'] ?? 'Security threat detected',
            linkUrl: args['linkUrl'],
            senderName: args['senderName'] ?? 'Unknown Sender',
          );
        },

        AppRoutes.mediaPreview: (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
                  {};
          return MediaPreviewScreen(
            attachmentType: args['type'] ?? 'document',
            filePath: args['filePath'] ?? 'path/to/file.pdf',
            caption: args['caption'],
          );
        },
      },
    );
  }
}
