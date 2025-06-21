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
  String get skip => 'Skip';

  @override
  String get back => 'Back';

  @override
  String get doIt => 'Do IT';

  @override
  String get onBoardingTitle1 => 'The Price Of Excellence\n is Discipline';

  @override
  String get onBoardingDesc1 => 'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle2 => 'Fitness Has Never Been So\n Much Fun';

  @override
  String get onBoardingDesc2 => 'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

  @override
  String get onBoardingTitle3 => 'NO MORE EXCUSES\n Do It Now';

  @override
  String get onBoardingDesc3 => 'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa';

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

  @override
  String get registerSuccess => 'Registration successful!';

  @override
  String get next => 'Next';

  @override
  String get finish => 'Finish';

  @override
  String get registrationTitle1 => 'TELL US ABOUT YOURSELF!';

  @override
  String get registrationSubtitle1 => 'We Need To Know Your Gender';

  @override
  String get registrationTitle2 => 'HOW OLD ARE YOU?';

  @override
  String get registrationSubtitle2 => 'This Helps Us Create Your Personalized Plan';

  @override
  String get registrationTitle3 => 'WHAT IS YOUR WEIGHT?';

  @override
  String get registrationSubtitle3 => 'We Use This For Calorie Calculations';

  @override
  String get registrationTitle4 => 'WHAT IS YOUR HEIGHT?';

  @override
  String get registrationSubtitle4 => 'This Helps Us Calculate Your BMI';

  @override
  String get registrationTitle5 => 'WHAT IS YOUR GOAL?';

  @override
  String get registrationSubtitle5 => 'Tell Us What You Want To Achieve';

  @override
  String get registrationTitle6 => 'HOW ACTIVE ARE YOU?';

  @override
  String get registrationSubtitle6 => 'Your Activity Level Helps Us Set Targets';

  @override
  String get year => 'Year';

  @override
  String get kg => 'Kg';

  @override
  String get cm => 'Cm';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get goalGainWeight => 'Gain Weight';

  @override
  String get goalLoseWeight => 'Lose Weight';

  @override
  String get goalGetFitter => 'Get Fitter';

  @override
  String get goalGainFlexibility => 'Gain More Flexibility';

  @override
  String get goalLearnBasics => 'Learn The Basics';

  @override
  String get activityRookie => 'Rookie';

  @override
  String get activityBeginner => 'Beginner';

  @override
  String get activityIntermediate => 'Intermediate';

  @override
  String get activityAdvanced => 'Advanced';

  @override
  String get activityTrueBeast => 'True Beast';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is Required';

  @override
  String get registerGreeting => 'Hi there';

  @override
  String get createAccount => 'Create An Account';

  @override
  String get register => 'Register';

  @override
  String get alreadyHaveAnAccount => 'Already Have An Account?';

  @override
  String get login => 'Login';

  @override
  String get food_Recommendation_title => 'Food Recommendation';

  @override
  String get food_Recommendation_no_categories => 'No categories found';
}
