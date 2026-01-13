// lib/presentation/providers/theme_provider.dart

import 'package:flutter/material.dart';
import '../../core/storage/local_storage.dart';
import '../../utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  final LocalStorage _localStorage;
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeProvider({required LocalStorage localStorage})
      : _localStorage = localStorage {
    _loadThemeMode();
  }

  ThemeMode get themeMode => _themeMode;

  // Load saved theme mode
  Future<void> _loadThemeMode() async {
    final savedMode = _localStorage.getString('theme_mode');
    if (savedMode != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedMode,
        orElse: () => ThemeMode.dark,
      );
      notifyListeners();
    }
  }

  // Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _localStorage.saveString('theme_mode', mode.toString());
    notifyListeners();
  }

  // Toggle theme
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  // Light Theme
  ThemeData get lightTheme => ThemeData(
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryLight,
          brightness: Brightness.light,
        ),
      );

  // Dark Theme
  ThemeData get darkTheme => ThemeData(
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
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentGreen,
          secondary: AppColors.accentBlue,
          surface: AppColors.surfaceDark,
        ),
      );
}
