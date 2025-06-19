// ignore_for_file: file_names

class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1';
  static const String loginEndpoint = '/auth/signin';
  static const String forgotPasswordEndpoint = '/auth/forgotPassword';
  static const String verifyOtpEndpoint = '/auth/verifyResetCode';
  static const String resetPasswordEndpoint = '/auth/resetPassword';
  static const String registerEndpoint = '/auth/signup';
}
