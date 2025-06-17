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

  @override
  String get login_heyThere => 'Hey There';

  @override
  String get login_welcomeBack => 'WELCOME BACK';

  @override
  String get login_title => 'Login';

  @override
  String get login_emailLabel => 'Email';

  @override
  String get login_emailHint => 'Enter your email';

  @override
  String get login_passwordLabel => 'Password';

  @override
  String get login_passwordHint => 'Enter your password';

  @override
  String get login_forgotPassword => 'Forgot Password?';

  @override
  String get login_orDivider => 'OR';

  @override
  String get login_noAccount => 'Don\'t have an account?';

  @override
  String get login_register => ' Register';

  @override
  String get login_socialTitle => 'Social Login';

  @override
  String get login_socialMessage => 'Social login is not implemented yet.';

  @override
  String get login_socialButton => 'Ok Got it';

  @override
  String get login_successTitle => 'Login Successful';

  @override
  String login_successMessage(String user) {
    return 'Welcome back, $user!';
  }

  @override
  String get login_failedTitle => 'Login Failed';

  @override
  String login_failedMessage(String error) {
    return '$error';
  }

  @override
  String get login_failedButton => 'Ok Got it';
}
