// lib/screens/session_expired_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../utils/constants.dart';

class SessionExpiredScreen extends StatelessWidget {
  final String? reason;
  
  const SessionExpiredScreen({
    super.key,
    this.reason = 'For your security, your session has expired.',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Warning Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  size: 40,
                  color: Colors.red,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Session Expired',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Reason
              Text(
                reason!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondaryDark,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Please log in again to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondaryDark,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Login Again',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Help Text
              TextButton(
                onPressed: () {
                  // Could show help dialog or navigate to help screen
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: AppColors.surfaceDark,
                      title: const Text('Need Help?', style: TextStyle(color: AppColors.textPrimaryDark)),
                      content: Text(
                        'If you continue to experience session issues, '
                        'please contact support at support@aegischat.com',
                        style: TextStyle(color: AppColors.textSecondaryDark),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK', style: TextStyle(color: AppColors.accentGreen)),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Having trouble?',
                  style: TextStyle(
                    color: AppColors.accentGreen,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}