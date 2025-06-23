import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ApiLocalizationService {
  static final ApiLocalizationService _instance = ApiLocalizationService._();
  factory ApiLocalizationService() => _instance;
  ApiLocalizationService._();

  String _currentLanguage = 'en';
  final sharedPrefs = getIt<SharedPreferences>();
  AppLocalizations? _currentLocalizations;

  Future<void> init() async {

    _currentLanguage = sharedPrefs.getString('language') ?? 'en';
  }

  Future<void> setLanguage(String lang) async {
    if (lang != 'ar' && lang != 'en') return;
    _currentLanguage = lang;
    await sharedPrefs.setString('language', lang);
  }

  void setLocalizations(AppLocalizations localizations) {
    _currentLocalizations = localizations;
  }

  bool get isArabic => _currentLanguage == 'ar';
  String get currentLanguage => _currentLanguage;
  Locale get currentLocale => Locale(_currentLanguage);

  String translate(String key, [Map<String, String>? params]) {
    if (_currentLocalizations != null) {
      // Use the new localization system
      switch (key) {
        case 'errors.no_internet':
          return _currentLocalizations!.networkError;
        case 'errors.server_error':
          return _currentLocalizations!.serverError;
        case 'errors.socket_exception':
          return _currentLocalizations!.socketException;
        case 'errors.format_exception':
          return _currentLocalizations!.formatException;
        case 'errors.timeout':
          return _currentLocalizations!.timeout;
        case 'errors.unexpected_error':
          return _currentLocalizations!.unknownError;
        case 'errors.request_cancelled':
          return _currentLocalizations!.requestCancelled;
        case 'errors.connection_error':
          return _currentLocalizations!.connectionError;
        case 'errors.unauthorized':
          return _currentLocalizations!.unauthorized;
        case 'errors.forbidden':
          return _currentLocalizations!.forbidden;
        case 'errors.not_found':
          return _currentLocalizations!.notFound;
        case 'errors.validation':
          return _currentLocalizations!.validationError;
        case 'errors.bad_request':
          return _currentLocalizations!.badRequest;
        case 'errors.unknown':
          return params != null && params.containsKey('message')
              ? _currentLocalizations!.errorWithMessage(params['message']!)
              : _currentLocalizations!.unknownError;
        case 'errors.status_code':
          return params != null && params.containsKey('status')
              ? _currentLocalizations!.errorWithStatusCode(params['status']!)
              : _currentLocalizations!.unknownError;
        default:
          break;
      }
    }

    final text = isArabic ? _arabicMessages[key] : _englishMessages[key] ?? key;

    if (params != null && params.isNotEmpty) {
      String result = text ?? '';
      params.forEach((key, value) {
        result = result.replaceAll('{$key}', value);
      });
      return result;
    }

    return text ?? '';
  }

  static const Map<String, String> _arabicMessages = {
    'errors.no_internet':
        'لا يوجد اتصال بالإنترنت. يرجى التحقق من شبكتك والمحاولة مرة أخرى.',
    'errors.socket_exception':
        'مشكلة في الاتصال بالخادم. يرجى التحقق من الإنترنت.',
    'errors.format_exception': 'تعذر قراءة البيانات المستلمة.',
    'errors.timeout': 'انتهت مدة الانتظار. يرجى المحاولة مرة أخرى.',
    'errors.unexpected_error': 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
    'errors.request_cancelled': 'تم إلغاء الطلب.',
    'errors.connection_error': 'خطأ في الاتصال بالشبكة.',
    'errors.unauthorized': 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.',
    'errors.forbidden': 'لا تملك صلاحية الوصول.',
    'errors.not_found': 'لم يتم العثور على البيانات المطلوبة.',
    'errors.server_error': 'خطأ في الخادم. يرجى المحاولة لاحقاً.',
    'errors.validation': 'البيانات المدخلة غير صحيحة.',
    'errors.bad_request': 'طلب غير صحيح.',
    'errors.unknown': 'حدث خطأ: {message}',
    'errors.status_code': 'حدث خطأ (كود: {status}).',
  };

  static const Map<String, String> _englishMessages = {
    'errors.no_internet':
        'No internet connection. Please check your network and try again.',
    'errors.socket_exception':
        'Connection problem. Please check your internet.',
    'errors.format_exception': 'Could not read the received data.',
    'errors.timeout': 'Connection timeout. Please try again.',
    'errors.unexpected_error':
        'An unexpected error occurred. Please try again.',
    'errors.request_cancelled': 'Request was cancelled.',
    'errors.connection_error': 'Connection error \n please check your network.',
    'errors.unauthorized': 'Login failed. Please try again.',
    'errors.forbidden': 'You do not have permission to access.',
    'errors.not_found': 'Requested data was not found.',
    'errors.server_error': 'Server error. Please try again later.',
    'errors.validation': 'The provided data is invalid.',
    'errors.bad_request': 'Invalid request.',
    'errors.unknown': 'Error occurred: {message}',
    'errors.status_code': 'Error occurred (code: {status}).',
  };
}
