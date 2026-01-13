// lib/data/repositories/mock_auth_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/storage/secure_storage.dart';
import '../../core/storage/local_storage.dart';
import '../models/user_model.dart';

/// Mock Authentication Repository for testing without a backend
/// This simulates successful API responses for login, register, and OTP verification
class MockAuthRepository {
  final SecureStorage _secureStorage;
  final LocalStorage _localStorage;

  MockAuthRepository({
    required SecureStorage secureStorage,
    required LocalStorage localStorage,
  })  : _secureStorage = secureStorage,
        _localStorage = localStorage;

  // Simulate login - always succeeds
  Future<Either<Failure, String>> login(String phoneNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    print('📱 MOCK: Login request for $phoneNumber');
    return const Right('OTP sent successfully (MOCK)');
  }

  // Simulate registration - always succeeds
  Future<Either<Failure, String>> register({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    print('📱 MOCK: Registration request for $phoneNumber');
    return const Right('OTP sent successfully (MOCK)');
  }

  // Simulate OTP verification - accepts any 6-digit code
  Future<Either<Failure, UserModel>> verifyOtp(
    String phoneNumber,
    String otp,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Accept any 6-digit OTP
    if (otp.length == 6) {
      print('✅ MOCK: OTP verified for $phoneNumber');
      
      // Create a mock user
      final user = UserModel(
        id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
        phoneNumber: phoneNumber,
        name: 'Test User',
        email: 'test@aegischat.com',
        createdAt: DateTime.now(),
        isOnline: true,
        isVerified: true,
        role: 'user', // Change to 'admin' to test admin features
      );

      // Save mock token and user ID
      await _secureStorage.saveAuthToken('mock_token_${user.id}');
      await _secureStorage.saveUserId(user.id);

      return Right(user);
    } else {
      print('❌ MOCK: Invalid OTP format');
      return const Left(AuthenticationFailure('Invalid OTP'));
    }
  }

  // Get current user - returns mock user
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final userId = await _secureStorage.getUserId();
    if (userId == null) {
      return const Left(AuthenticationFailure('User not logged in'));
    }

    // Return mock user
    final user = UserModel(
      id: userId,
      phoneNumber: '+92 300 1234567',
      name: 'Test User',
      email: 'test@aegischat.com',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      isOnline: true,
      isVerified: true,
      role: 'user',
    );

    return Right(user);
  }

  // Logout
  Future<Either<Failure, void>> logout() async {
    await _secureStorage.clearAll();
    await _localStorage.clearAll();
    print('👋 MOCK: User logged out');
    return const Right(null);
  }

  // Check if authenticated
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.getAuthToken();
    return token != null;
  }
}
