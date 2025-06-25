import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'api_result.dart';
import '../services/connectivity_service.dart';
import '../services/api_localization_service.dart';

class ErrorHandler {
  ErrorHandler._();
  static final ConnectivityService _connectivityService = ConnectivityService();
  static final ApiLocalizationService _localization = ApiLocalizationService();

  static Future<ApiResult<T>> handle<T>(Future<T> Function() request) async {
    if (!(await _connectivityService.isConnected())) {
      return ApiFailure(_localization.translate('errors.no_internet'));
    }

    try {
      final response = await request();
      return ApiSuccess(response);
    } on DioException catch (e) {
      return ApiFailure(_handleDioError(e));
    } on SocketException {
      return ApiFailure(_localization.translate('errors.socket_exception'));
    } on FormatException {
      return ApiFailure(_localization.translate('errors.format_exception'));
    } catch (e) {
      debugPrint('Unexpected error in RequestHandler: $e');
      return ApiFailure(_localization.translate('errors.unexpected_error'));
    }
  }

  static String _handleDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        _localization.translate('errors.timeout'),
      DioExceptionType.badResponse when e.response != null =>
        _handleBadResponse(e.response!),
      DioExceptionType.cancel => _localization.translate(
          'errors.request_cancelled',
        ),
      DioExceptionType.connectionError => _localization.translate(
          'errors.connection_error',
        ),
      _ when e.error is SocketException => _localization.translate(
          'errors.no_internet',
        ),
      _ => _localization.translate('errors.unknown', {
          'message': e.message ?? '',
        }),
    };
  }

  static String _handleBadResponse(Response response) {
    final statusCode = response.statusCode;
    final errorMessage = _extractErrorMessage(response);

    if (errorMessage != null && errorMessage.isNotEmpty) {
      return errorMessage;
    }

    return switch (statusCode) {
      400 => _localization.translate('errors.bad_request'),
      401 => _localization.translate('errors.unauthorized'),
      403 => _localization.translate('errors.forbidden'),
      404 => _localization.translate('errors.not_found'),
      422 => _extractValidationErrors(response),
      500 || 502 || 503 => _localization.translate('errors.server_error'),
      _ => _localization.translate('errors.status_code', {
          'status': statusCode?.toString() ?? 'unknown',
        }),
    };
  }

  static String? _extractErrorMessage(Response response) {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        return data['message']?.toString() ??
            data['error']?.toString() ??
            data['errors']?.toString() ??
            data['detail']?.toString();
      } else if (response.data is String &&
          (response.data as String).isNotEmpty) {
        return response.data as String;
      }
    } catch (ex) {
      debugPrint('Error parsing error message: $ex');
    }
    return null;
  }

  static String _extractValidationErrors(Response response) {
    try {
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('errors') &&
            data['errors'] is Map<String, dynamic>) {
          final errors = data['errors'] as Map<String, dynamic>;
          final errorMessages = <String>[];

          errors.forEach((key, value) {
            if (value is List) {
              errorMessages.addAll(value.map((e) => e.toString()));
            } else {
              errorMessages.add('$key: $value');
            }
          });

          if (errorMessages.isNotEmpty) {
            return errorMessages.join('\n');
          }
        }
      }
    } catch (ex) {
      debugPrint('Error parsing validation errors: $ex');
    }
    return _localization.translate('errors.validation');
  }
}
