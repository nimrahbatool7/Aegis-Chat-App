// lib/presentation/screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    print('🚀 SplashScreen: Starting auth check...');
    try {
      // For now, let's just wait 2 seconds and go to login
      // to ensure the app is actually running and can navigate
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        print('🚀 SplashScreen: Navigating to login...');
        Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
      }
    } catch (e) {
      print('❌ SplashScreen Error: $e');
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Aegis Chat',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Secure Messaging',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
