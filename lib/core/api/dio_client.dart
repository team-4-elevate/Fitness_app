// core/api/dio_client.dart
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/exceptions/failure.dart';
import 'package:fitness_app/core/helper/error_handler.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Singleton(as: ApiClient)
class DioApiClient implements ApiClient {
  final Dio _dio;
  final AppSecureStorage localStorage;

  DioApiClient(this.localStorage)
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            responseType: ResponseType.json,
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log('kkkkk');
        log(options.headers.toString());
        log(options.path);
        log(options.queryParameters.toString());
        log(options.data.toString());
        return handler.next(options);
      },
    ));
    _dio.interceptors.add(PrettyDioLogger());
  }

  @override
  Future<ApiResult<T>> get<T>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.get(
        _buildUrl(path, baseUrl),
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.post(
        _buildUrl(path, baseUrl),
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.put(
        _buildUrl(path, baseUrl),
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> patch<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.patch(
        _buildUrl(path, baseUrl),
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> delete<T>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.delete(
        _buildUrl(path, baseUrl),
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  /// Builds the complete URL based on baseUrl parameter
  /// If baseUrl is provided, it will be used instead of the default one
  /// If path starts with 'http', it will be treated as a complete URL
  String _buildUrl(String path, String? baseUrl) {
    // If path is already a complete URL (starts with http), return as is
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }

    // If custom baseUrl is provided, use it with the exact path provided
    if (baseUrl != null) {
      // Remove trailing slash from baseUrl if present
      final cleanBaseUrl = baseUrl.endsWith('/')
          ? baseUrl.substring(0, baseUrl.length - 1)
          : baseUrl;

      // Use the path exactly as provided (don't add leading slash)
      return '$cleanBaseUrl$path';
    }

    // Use default baseUrl from Dio configuration with the path as-is
    return path;
  }

  T _handleResponse<T>(dynamic responseData) {
    if (T.toString() == 'Map<String, dynamic>' || T == dynamic) {
      return responseData as T;
    }

    if (T.toString() == 'List<Map<String, dynamic>>') {
      return responseData as T;
    }

    if (T.toString().startsWith('List<') && responseData is List) {
      return responseData as T;
    }

    try {
      return responseData as T;
    } catch (e) {
      throw Exception(
        'Cannot convert response data to type $T. '
        'Response type: ${responseData.runtimeType}. '
        'Response: $responseData',
      );
    }
  }

  Future<void> _checkToken(bool requiresToken) async {
    if (!requiresToken) return;

    try {
      final token = await localStorage.getToken();
      if (token != null) {
        log('1- null ${token}');
        _dio.options.headers['Authorization'] = 'Bearer $token';
        log(_dio.options.headers.toString());
      } else {
        throw ServerFailure(errorMessage: 'User token is null');
      }
    } catch (e) {
      throw ServerFailure(errorMessage: 'Token error: ${e.toString()}');
    }
  }
}
