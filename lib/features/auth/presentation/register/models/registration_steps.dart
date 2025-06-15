// features/auth/domain/models/registration_steps.dart
class RegistrationSteps {
  static const List<String> titles = [
    'TELL US ABOUT YOURSELF!',
    'HOW OLD ARE YOU?',
    'WHAT IS YOUR WEIGHT?',
    'WHAT IS YOUR HEIGHT?',
    'WHAT IS YOUR GOAL?',
    'HOW ACTIVE ARE YOU?',
  ];

  static const List<String> subtitles = [
    'We Need To Know Your Gender',
    'This Helps Us Create Your Personalized Plan',
    'We Use This For Calorie Calculations',
    'This Helps Us Calculate Your BMI',
    'Tell Us What You Want To Achieve',
    'Your Activity Level Helps Us Set Targets',
  ];

  static String getTitleForStep(int step) {
    if (step >= 1 && step <= titles.length) {
      return titles[step - 1];
    }
    return '';
  }

  static String getSubtitleForStep(int step) {
    if (step >= 1 && step <= subtitles.length) {
      return subtitles[step - 1];
    }
    return '';
  }
}
