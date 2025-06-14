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
  String get networkError =>
      'No internet connection. Please check your network and try again.';

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
  String get socketException =>
      'Connection problem. Please check your internet.';

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
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get doIt => 'Do IT';

  @override
  String get onBoardingTitle1 => 'The Price Of Excellence\n is Discipline';

  @override
  String get onBoardingDesc1 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle2 => 'Fitness Has Never Been So\n Much Fun';

  @override
  String get onBoardingDesc2 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle3 => 'NO MORE EXCUSES\n Do It Now';

  @override
  String get onBoardingDesc3 =>
      'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';
}
