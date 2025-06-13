import 'package:dio/dio.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final AppSecureStorage localStorage;

  AuthInterceptor(this.localStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('login') ||
        options.path.contains('register') ||
        options.path.contains('forgot-password')) {
      return handler.next(options);
    }

    final token = await localStorage.getToken();

    if (token != null) {
      options.headers['token'] = token;
    }

    return handler.next(options);
  }
}
