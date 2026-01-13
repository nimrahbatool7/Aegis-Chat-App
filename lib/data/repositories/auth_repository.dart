// lib/data/repositories/auth_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/storage/secure_storage.dart';
import '../../core/storage/local_storage.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorage _secureStorage;
  final LocalStorage _localStorage;

  AuthRepository({
    required ApiClient apiClient,
    required SecureStorage secureStorage,
    required LocalStorage localStorage,
  })  : _apiClient = apiClient,
        _secureStorage = secureStorage,
        _localStorage = localStorage;

  // Login with phone number (sends OTP)
  Future<Either<Failure, String>> login(String phoneNumber) async {
    try {
      final response = await _apiClient.post(
        '/auth/login',
        data: {'phone_number': phoneNumber},
      );

      if (response.statusCode == 200) {
        return Right(response.data['message'] ?? 'OTP sent successfully');
      } else {
        return const Left(ServerFailure('Failed to send OTP'));
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  // Verify OTP and complete login
  Future<Either<Failure, UserModel>> verifyOtp(
    String phoneNumber,
    String otp,
  ) async {
    try {
      final response = await _apiClient.post(
        '/auth/verify-otp',
        data: {
          'phone_number': phoneNumber,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['user']);
        final token = response.data['token'];

        // Save auth data
        await _secureStorage.saveAuthToken(token);
        await _secureStorage.saveUserId(user.id);

        return Right(user);
      } else {
        return const Left(AuthenticationFailure('Invalid OTP'));
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  // Register new user
  Future<Either<Failure, String>> register({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/register',
        data: {
          'phone_number': phoneNumber,
          'name': name,
          'email': email,
        },
      );

      if (response.statusCode == 201) {
        return Right(response.data['message'] ?? 'OTP sent successfully');
      } else {
        return const Left(ServerFailure('Failed to register'));
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  // Get current user
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final userId = await _secureStorage.getUserId();
      if (userId == null) {
        return const Left(AuthenticationFailure('User not logged in'));
      }

      final response = await _apiClient.get('/users/$userId');

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        return Right(user);
      } else {
        return const Left(ServerFailure('Failed to get user'));
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  // Logout
  Future<Either<Failure, void>> logout() async {
    try {
      await _apiClient.post('/auth/logout');
      await _secureStorage.clearAll();
      await _localStorage.clearAll();
      return const Right(null);
    } catch (e) {
      // Even if API call fails, clear local data
      await _secureStorage.clearAll();
      await _localStorage.clearAll();
      return const Right(null);
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.getAuthToken();
    return token != null;
  }
}
