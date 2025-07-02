import 'package:fitness_app/core/helper/api_result.dart';

abstract class ApiClient {
  Future<ApiResult<T>> get<T>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<ApiResult<T>> delete<T>(
    String path, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<ApiResult<T>> patch<T>(
    String path, {
    dynamic data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });
}
