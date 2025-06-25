import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Fitness App'**
  String get appTitle;

  /// A simple greeting
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Welcome message for users
  ///
  /// In en, this message translates to:
  /// **'Welcome to Fitness App'**
  String get welcome;

  /// Error message when there's no network connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get networkError;

  /// Error message for server errors
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// Error message for unknown errors
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unknownError;

  /// Error message for timeouts
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please try again.'**
  String get timeout;

  /// Error message for unauthorized access
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get unauthorized;

  /// Error message for forbidden access
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access.'**
  String get forbidden;

  /// Error message for not found resources
  ///
  /// In en, this message translates to:
  /// **'Requested data was not found.'**
  String get notFound;

  /// Error message for validation errors
  ///
  /// In en, this message translates to:
  /// **'The provided data is invalid.'**
  String get validationError;

  /// Error message for bad requests
  ///
  /// In en, this message translates to:
  /// **'Invalid request.'**
  String get badRequest;

  /// Error message for cancelled requests
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled.'**
  String get requestCancelled;

  /// Error message for connection errors
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your network.'**
  String get connectionError;

  /// Error message for socket exceptions
  ///
  /// In en, this message translates to:
  /// **'Connection problem. Please check your internet.'**
  String get socketException;

  /// Error message for format exceptions
  ///
  /// In en, this message translates to:
  /// **'Could not read the received data.'**
  String get formatException;

  /// Error message with a parameter
  ///
  /// In en, this message translates to:
  /// **'Error occurred: {message}'**
  String errorWithMessage(String message);

  /// Error message with status code
  ///
  /// In en, this message translates to:
  /// **'Error occurred (code: {status}).'**
  String errorWithStatusCode(String status);

  /// Button to skip onboarding
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Button to go to previous onboarding page
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Button to proceed after onboarding
  ///
  /// In en, this message translates to:
  /// **'Do IT'**
  String get doIt;

  /// Title for onboarding screen 1
  ///
  /// In en, this message translates to:
  /// **'The Price Of Excellence\n is Discipline'**
  String get onBoardingTitle1;

  /// Description for onboarding screen 1
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa'**
  String get onBoardingDesc1;

  /// Title for onboarding screen 2
  ///
  /// In en, this message translates to:
  /// **'Fitness Has Never Been So\n Much Fun'**
  String get onBoardingTitle2;

  /// Description for onboarding screen 2
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa'**
  String get onBoardingDesc2;

  /// Title for onboarding screen 3
  ///
  /// In en, this message translates to:
  /// **'NO MORE EXCUSES\n Do It Now'**
  String get onBoardingTitle3;

  /// Description for onboarding screen 3
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa'**
  String get onBoardingDesc3;

  /// Greeting text on login page
  ///
  /// In en, this message translates to:
  /// **'Hey There'**
  String get login_heyThere;

  /// Welcome back message on login page
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get login_welcomeBack;

  /// Title for the login page
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_title;

  /// Label for the email input field on the login page
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_emailLabel;

  /// Hint text for the email input field on the login page
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get login_emailHint;

  /// Label for the password input field on the login page
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_passwordLabel;

  /// Hint text for the password input field on the login page
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get login_passwordHint;

  /// Text for the forgot password link on the login page
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get login_forgotPassword;

  /// Divider text between login options
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get login_orDivider;

  /// Text for no account message on login page
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get login_noAccount;

  /// Text for register link on login page
  ///
  /// In en, this message translates to:
  /// **' Register'**
  String get login_register;

  /// Title for the social login section
  ///
  /// In en, this message translates to:
  /// **'Social Login'**
  String get login_socialTitle;

  /// Message indicating that social login is not yet implemented
  ///
  /// In en, this message translates to:
  /// **'Social login is not implemented yet.'**
  String get login_socialMessage;

  /// Button text for acknowledging social login message
  ///
  /// In en, this message translates to:
  /// **'Ok Got it'**
  String get login_socialButton;

  /// Title for login success dialog
  ///
  /// In en, this message translates to:
  /// **'Login Successful'**
  String get login_successTitle;

  /// Login success message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {user}!'**
  String login_successMessage(String user);

  /// Title for login failure dialog
  ///
  /// In en, this message translates to:
  /// **'Login Failed'**
  String get login_failedTitle;

  /// Login failure message with error details
  ///
  /// In en, this message translates to:
  /// **'{error}'**
  String login_failedMessage(String error);

  /// Button text for acknowledging login failure
  ///
  /// In en, this message translates to:
  /// **'Ok Got it'**
  String get login_failedButton;

  /// Message displayed when registration is successful
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registerSuccess;

  /// Button text for the next step
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Button text for the final step
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Title for gender selection step
  ///
  /// In en, this message translates to:
  /// **'TELL US ABOUT YOURSELF!'**
  String get registrationTitle1;

  /// Subtitle for gender selection step
  ///
  /// In en, this message translates to:
  /// **'We Need To Know Your Gender'**
  String get registrationSubtitle1;

  /// Title for age selection step
  ///
  /// In en, this message translates to:
  /// **'HOW OLD ARE YOU?'**
  String get registrationTitle2;

  /// Subtitle for age selection step
  ///
  /// In en, this message translates to:
  /// **'This Helps Us Create Your Personalized Plan'**
  String get registrationSubtitle2;

  /// Title for weight selection step
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR WEIGHT?'**
  String get registrationTitle3;

  /// Subtitle for weight selection step
  ///
  /// In en, this message translates to:
  /// **'We Use This For Calorie Calculations'**
  String get registrationSubtitle3;

  /// Title for height selection step
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR HEIGHT?'**
  String get registrationTitle4;

  /// Subtitle for height selection step
  ///
  /// In en, this message translates to:
  /// **'This Helps Us Calculate Your BMI'**
  String get registrationSubtitle4;

  /// Title for goal selection step
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR GOAL?'**
  String get registrationTitle5;

  /// Subtitle for goal selection step
  ///
  /// In en, this message translates to:
  /// **'Tell Us What You Want To Achieve'**
  String get registrationSubtitle5;

  /// Title for activity level selection step
  ///
  /// In en, this message translates to:
  /// **'HOW ACTIVE ARE YOU?'**
  String get registrationTitle6;

  /// Subtitle for activity level selection step
  ///
  /// In en, this message translates to:
  /// **'Your Activity Level Helps Us Set Targets'**
  String get registrationSubtitle6;

  /// Label for age selection
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// Label for weight selection
  ///
  /// In en, this message translates to:
  /// **'Kg'**
  String get kg;

  /// Label for height selection
  ///
  /// In en, this message translates to:
  /// **'Cm'**
  String get cm;

  /// Label for male gender option
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// Label for female gender option
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// Goal option to gain weight
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get goalGainWeight;

  /// Goal option to lose weight
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get goalLoseWeight;

  /// Goal option to get fitter
  ///
  /// In en, this message translates to:
  /// **'Get Fitter'**
  String get goalGetFitter;

  /// Goal option to gain flexibility
  ///
  /// In en, this message translates to:
  /// **'Gain More Flexibility'**
  String get goalGainFlexibility;

  /// Goal option to learn basics
  ///
  /// In en, this message translates to:
  /// **'Learn The Basics'**
  String get goalLearnBasics;

  /// Activity level option for rookie
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get activityRookie;

  /// Activity level option for beginner
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get activityBeginner;

  /// Activity level option for intermediate
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get activityIntermediate;

  /// Activity level option for advanced
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get activityAdvanced;

  /// Activity level option for true beast
  ///
  /// In en, this message translates to:
  /// **'True Beast'**
  String get activityTrueBeast;

  /// Label for first name input field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Label for last name input field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Label for email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Error message when password field is empty
  ///
  /// In en, this message translates to:
  /// **'Password is Required'**
  String get passwordRequired;

  /// Greeting text on register page
  ///
  /// In en, this message translates to:
  /// **'Hi there'**
  String get registerGreeting;

  /// Title for register page
  ///
  /// In en, this message translates to:
  /// **'Create An Account'**
  String get createAccount;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Text asking if user already has an account on register page
  ///
  /// In en, this message translates to:
  /// **'Already Have An Account?'**
  String get alreadyHaveAnAccount;

  /// Login text for buttons and links
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @food_Recommendation_title.
  ///
  /// In en, this message translates to:
  /// **'Food Recommendation'**
  String get food_Recommendation_title;

  /// No description provided for @food_Recommendation_no_categories.
  ///
  /// In en, this message translates to:
  /// **'No categories found'**
  String get food_Recommendation_no_categories;

  /// No description provided for @food_food_Recommendation_fail_to_loadCategories.
  ///
  /// In en, this message translates to:
  /// **'Failed to load categories'**
  String get food_food_Recommendation_fail_to_loadCategories;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'retry'**
  String get retry;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @enterFourDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter 4 digit code'**
  String get enterFourDigitCode;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @enterYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter Your OTP'**
  String get enterYourOtp;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check Your Email'**
  String get checkYourEmail;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'OTP CODE'**
  String get otpCode;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get enterYourEmail;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @didntReceiveVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t Receive Verification Code?'**
  String get didntReceiveVerificationCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
