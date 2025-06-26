// core/Constant/api_constants.dart
// ignore_for_file: file_names

class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1';
  static const String loginEndpoint = '/auth/signin';
  static const String forgotPasswordEndpoint = '/auth/forgotPassword';
  static const String verifyOtpEndpoint = '/auth/verifyResetCode';
  static const String resetPasswordEndpoint = '/auth/resetPassword';
  static const String registerEndpoint = '/auth/signup';
  static const String difficultyLevel = '/levels';
  static const String exercises = '/exercises';
  static const String foodRecommendBaseUrl =
      'https://www.themealdb.com/api/json/v1/1/';
  static const String foodRecommendedCategoriesEndpoint = '/categories.php';
  static const String foodRecommendedMealsEndpoint = '/filter.php';
  static const String muscles = '/muscles';
  static const String getFoodDetailsEndpoint = '/lookup.php';
}
