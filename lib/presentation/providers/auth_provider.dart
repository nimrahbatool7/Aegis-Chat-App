// lib/presentation/providers/auth_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final dynamic _authRepository;

  AuthProvider({required dynamic authRepository})
      : _authRepository = authRepository;

  // State
  AuthState _state = AuthState.initial;
  UserModel? _currentUser;
  String? _errorMessage;
  String? _phoneNumber; // Store phone number for OTP verification

  // Getters
  AuthState get state => _state;
  UserModel? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  String? get phoneNumber => _phoneNumber;
  bool get isAuthenticated => _state == AuthState.authenticated && _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;
  bool get isSuperAdmin => _currentUser?.isSuperAdmin ?? false;

  // Check authentication status on app start
  Future<void> checkAuthStatus() async {
    _state = AuthState.loading;
    notifyListeners();

    final isAuth = await _authRepository.isAuthenticated();
    
    if (isAuth) {
      final result = await _authRepository.getCurrentUser();
      result.fold(
        (failure) {
          _state = AuthState.unauthenticated;
          _errorMessage = failure.message;
          notifyListeners();
        },
        (user) {
          _currentUser = user;
          _state = AuthState.authenticated;
          notifyListeners();
        },
      );
    } else {
      _state = AuthState.unauthenticated;
      notifyListeners();
    }
  }

  // Login - Send OTP
  Future<bool> login(String phoneNumber) async {
    _state = AuthState.loading;
    _errorMessage = null;
    _phoneNumber = phoneNumber;
    notifyListeners();

    final result = await _authRepository.login(phoneNumber);

    return result.fold(
      (failure) {
        _state = AuthState.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (message) {
        _state = AuthState.unauthenticated; // Waiting for OTP
        notifyListeners();
        return true;
      },
    );
  }

  // Register - Send OTP
  Future<bool> register({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    _state = AuthState.loading;
    _errorMessage = null;
    _phoneNumber = phoneNumber;
    notifyListeners();

    final result = await _authRepository.register(
      phoneNumber: phoneNumber,
      name: name,
      email: email,
    );

    return result.fold(
      (failure) {
        _state = AuthState.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (message) {
        _state = AuthState.unauthenticated; // Waiting for OTP
        notifyListeners();
        return true;
      },
    );
  }

  // Verify OTP
  Future<bool> verifyOtp(String otp) async {
    if (_phoneNumber == null) {
      _errorMessage = 'Phone number not found';
      _state = AuthState.error;
      notifyListeners();
      return false;
    }

    _state = AuthState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _authRepository.verifyOtp(_phoneNumber!, otp);

    return result.fold(
      (failure) {
        _state = AuthState.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (user) {
        _currentUser = user;
        _state = AuthState.authenticated;
        _phoneNumber = null; // Clear phone number
        notifyListeners();
        return true;
      },
    );
  }

  // Logout
  Future<void> logout() async {
    _state = AuthState.loading;
    notifyListeners();

    await _authRepository.logout();

    _currentUser = null;
    _state = AuthState.unauthenticated;
    _errorMessage = null;
    _phoneNumber = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Update user
  void updateUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }
}
