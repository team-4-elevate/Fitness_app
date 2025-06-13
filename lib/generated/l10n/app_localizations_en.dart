// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fitness App';

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome to Fitness App';

  @override
  String get networkError => 'No internet connection. Please check your network and try again.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get unknownError => 'An unexpected error occurred. Please try again.';

  @override
  String get timeout => 'Connection timeout. Please try again.';

  @override
  String get unauthorized => 'Login failed. Please try again.';

  @override
  String get forbidden => 'You do not have permission to access.';

  @override
  String get notFound => 'Requested data was not found.';

  @override
  String get validationError => 'The provided data is invalid.';

  @override
  String get badRequest => 'Invalid request.';

  @override
  String get requestCancelled => 'Request was cancelled.';

  @override
  String get connectionError => 'Connection error. Please check your network.';

  @override
  String get socketException => 'Connection problem. Please check your internet.';

  @override
  String get formatException => 'Could not read the received data.';

  @override
  String errorWithMessage(String message) {
    return 'Error occurred: $message';
  }

  @override
  String errorWithStatusCode(String status) {
    return 'Error occurred (code: $status).';
  }
}
