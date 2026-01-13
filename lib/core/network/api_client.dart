// lib/core/network/api_client.dart

import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../errors/exceptions.dart';
import '../storage/secure_storage.dart';

class ApiClient {
  late final Dio _dio;
  final SecureStorage _secureStorage;

  ApiClient(this._secureStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_loggingInterceptor());
    _dio.interceptors.add(_errorInterceptor());
  }

  // Auth Interceptor - Adds token to requests
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _secureStorage.getAuthToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    );
  }

  // Logging Interceptor - Logs requests and responses
  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}');
        handler.next(error);
      },
    );
  }

  // Error Interceptor - Handles common errors
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: const NetworkException('Connection timeout'),
            ),
          );
        } else if (error.type == DioExceptionType.connectionError) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: const NetworkException('No internet connection'),
            ),
          );
        } else {
          handler.next(error);
        }
      },
    );
  }

  // GET Request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT Request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE Request
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Handle Dio Errors
  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkException('Connection timeout');
      
      case DioExceptionType.connectionError:
        return const NetworkException('No internet connection');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return const AuthenticationException('Unauthorized');
        } else if (statusCode == 403) {
          return const AuthenticationException('Forbidden');
        } else if (statusCode == 404) {
          return const ServerException('Resource not found');
        } else if (statusCode == 500) {
          return const ServerException('Internal server error');
        } else {
          return ServerException(
            error.response?.data['message'] ?? 'Unknown server error',
          );
        }
      
      default:
        return const ServerException('Unknown error occurred');
    }
  }
}
