// core/Constant/api_constants.dart
// ignore_for_file: file_names

class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1';
  static const String loginEndpoint = '/auth/signin';
  static const String registerEndpoint = '/auth/signup';
  
  // Forgot password flow endpoints
  static const String forgotPasswordEndpoint = '/auth/forgotPassword';
  static const String verifyOtpEndpoint = '/auth/verifyResetCode';
  static const String resetPasswordEndpoint = '/auth/resetPassword';
}
