// core/api/dio_client.dart
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
    _dio.interceptors.add(PrettyDioLogger());
  }

  @override
  Future<ApiResult<T>> get<T>(
    String path, {
    String? secondBaseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final String url = secondBaseUrl != null ? '$secondBaseUrl$path' : path;
      final response = await _dio.get(url, queryParameters: queryParameters);
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.post(
        path,
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
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.put(
        path,
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
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
  }

  @override
  Future<ApiResult<T>> delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  }) async {
    return await ErrorHandler.handle<T>(() async {
      await _checkToken(requiresToken);
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return _handleResponse<T>(response.data);
    });
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
        _dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        throw ServerFailure(errorMessage: 'User token is null');
      }
    } catch (e) {
      throw ServerFailure(errorMessage: 'Token error: ${e.toString()}');
    }
  }
}
