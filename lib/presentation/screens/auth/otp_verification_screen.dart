// lib/presentation/screens/auth/otp_verification_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/auth_provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool _isLoading = false;
  int _secondsRemaining = 300; // 5 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _timerText {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _handleVerifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.verifyOtp(_otpController.text.trim());

    setState(() => _isLoading = false);

    if (success && mounted) {
      // Navigate to chat list
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppConstants.chatListRoute,
        (route) => false,
      );
    } else if (mounted) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Invalid OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleResendOtp() async {
    if (_secondsRemaining > 0) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.login(widget.phoneNumber);

    if (success && mounted) {
      setState(() => _secondsRemaining = 300);
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Icon(
                  Icons.message,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Enter Verification Code',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'We sent a code to ${widget.phoneNumber}',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // OTP Field
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  validator: Validators.otp,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'OTP Code',
                    hintText: '000000',
                    counterText: '',
                  ),
                  onChanged: (value) {
                    // Auto-submit when 6 digits entered
                    if (value.length == 6) {
                      _handleVerifyOtp();
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Timer
                if (_secondsRemaining > 0)
                  Text(
                    'Code expires in $_timerText',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 24),

                // Verify Button
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleVerifyOtp,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Verify'),
                  ),
                ),
                const SizedBox(height: 16),

                // Resend OTP
                TextButton(
                  onPressed: _secondsRemaining > 0 ? null : _handleResendOtp,
                  child: Text(
                    _secondsRemaining > 0
                        ? 'Resend OTP in $_timerText'
                        : 'Resend OTP',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
