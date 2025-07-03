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
  String get registrationSubtitle2 =>
      'This Helps Us Create Your Personalized Plan';

  @override
  String get registrationTitle3 => 'WHAT IS YOUR WEIGHT?';

  @override
  String get registrationSubtitle3 => 'We Use This For Calorie Calculations';

  @override
  String data_parse_error_upcoming_workouts(String error) {
    return 'Failed to parse upcoming workouts: $error';
  }

  @override
  String data_parse_error_food_recommendations(String error) {
    return 'Failed to parse food recommendations: $error';
  }

  @override
  String data_network_error(String error) {
    return 'Network error: $error';
  }

  @override
  String domain_error_loading_data(String message) {
    return 'Error loading data: $message';
  }

  @override
  String get dailyToRecommendations => 'Daily To Recommendations';

  @override
  String get home_upcoming_workouts => 'Upcoming Workouts';

  @override
  String get home_recommendations_for_you => 'Recommendations For You';

  @override
  String get home_popular_training => 'Popular Training';

  @override
  String get home_see_all => 'See All';

  @override
  String home_error_upcoming_workouts(String error) {
    return 'Error loading upcoming workouts: $error';
  }

  @override
  String home_error_loading_upcoming_workouts(String error) {
    return 'Error loading upcoming workouts: $error';
  }

  @override
  String home_error_food_recommendations(String error) {
    return 'Error loading food recommendations: $error';
  }

  @override
  String home_error_loading_food_recommendations(String error) {
    return 'Error loading food recommendations: $error';
  }

  @override
  String home_error_loading_daily_recommendations(String error) {
    return 'Error loading daily recommendations: $error';
  }

  @override
  String get failed_to_parse_upcoming_workouts =>
      'Failed to parse upcoming workouts:';

  @override
  String get let_s_start_your_day => 'Let\'s Start Your Day';

  @override
  String get category_gym => 'Gym';

  @override
  String get category_fitness => 'Fitness';

  @override
  String get category_yoga => 'Yoga';

  @override
  String get category_aerobics => 'Aerobics';

  @override
  String get category_trainer => 'Trainer';

  @override
  String get workout_category_full_body => 'Full Body';

  @override
  String get workout_category_chest => 'Chest';

  @override
  String get workout_category_arm => 'Arm';

  @override
  String get workout_category_leg => 'Leg';

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
  String get registrationSubtitle6 =>
      'Your Activity Level Helps Us Set Targets';

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

  @override
  String get food_food_Recommendation_fail_to_loadCategories =>
      'Failed to load categories';

  @override
  String get retry => 'retry';

  @override
  String get confirmPassword => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get enterFourDigitCode => 'Please enter 4 digit code';

  @override
  String get confirm => 'Confirm';

  @override
  String get enterYourOtp => 'Enter Your OTP';

  @override
  String get checkYourEmail => 'Check Your Email';

  @override
  String get otpCode => 'OTP CODE';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get enterYourEmail => 'Enter your Email';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get didntReceiveVerificationCode =>
      'Didn\'t Receive Verification Code?';

  @override
  String get resend => 'Resend';

  @override
  String get video_not_available => 'Video not available';

  @override
  String get exercise => 'Exercise';

  @override
  String get no_exercises_found => 'No exercises found';

  @override
  String failed_to_load_exercises(Object error) {
    return 'Failed to load exercises';
  }

  @override
  String get motivational_quote => 'Motivational Quote';

  @override
  String get upload_image => 'Uploading image...';

  @override
  String get loading => 'Loading...';

  @override
  String get first_name => 'First Name';

  @override
  String get second_name => 'Second Name';

  @override
  String get email_hint => 'user@mail.co';

  @override
  String get your_weight => 'Your Weight';

  @override
  String get weight_hint => '70';

  @override
  String get your_goal => 'Your Goal';

  @override
  String get gain_weight => 'Gain weight';

  @override
  String get your_activity_level => 'Your Activity Level';

  @override
  String get edit_weight => 'Edit Weight';

  @override
  String get edit_goal => 'Edit Goal';

  @override
  String get edit_activity_level => 'Edit Activity Level';

  @override
  String get what_is_your_activity_level => 'WHAT IS YOUR ACTIVITY LEVEL?';

  @override
  String get activity_level_help_text =>
      'This helps us calculate your daily calorie needs';

  @override
  String get done => 'Done';

  @override
  String get edit_profile => 'Edit Profile';

  @override
  String get what_is_your_goal => 'WHAT IS YOUR GOAL?';

  @override
  String get goal_help_text => 'This helps us create your personalized plan';

  @override
  String get tap_to_edit => 'tap to Edit';

  @override
  String get what_is_your_weight => 'WHAT IS YOUR WEIGHT?';

  @override
  String get weight_help_text => 'This helps us create your personalized plan';

  @override
  String get kg_unit => 'Kg';

  @override
  String get enter_old_new_passwords => 'Enter your old, new passwords';

  @override
  String get update_password => 'Update Password';

  @override
  String get password_updated_successfully => 'Password updated successfully';

  @override
  String get current_password => 'Current Password';

  @override
  String get new_password => 'New Password';

  @override
  String get confirm_new_password => 'Confirm New Password';

  @override
  String get please_confirm_password => 'Please confirm your password';

  @override
  String get passwords_do_not_match => 'Passwords do not match';

  @override
  String get profile_title => 'Profile';

  @override
  String get change_password => 'Change Password';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get notification => 'Notifications';

  @override
  String get privacy => 'Privacy';

  @override
  String get help => 'Help';

  @override
  String get about => 'About';

  @override
  String get logout => 'Logout';

  @override
  String selectedLanguageValue(String lang) {
    return 'Selected Language ($lang)';
  }

  @override
  String get logout_confirmation_title => 'Logout Confirmation';

  @override
  String get logout_message_body =>
      'Are you sure you want to logout from your account?';

  @override
  String get cancel => 'Cancel';

  @override
  String get smartCoachTitle => 'Smart coach';

  @override
  String get smartCoachAppBarDesc => 'I am your smart coach';

  @override
  String get smartCoachGreeting => 'Hi ';

  @override
  String get drawerTitle => 'Previous Conversations';

  @override
  String get noConversations => 'No conversations found';

  @override
  String get smartCoachHintTxt => 'Ask anything...';

  @override
  String get typingMsg => 'Typing';

  @override
  String get welcomeTitle => 'How Can I Assist You Today ?';

  @override
  String get welcomeBtn => 'Get Started';
}
