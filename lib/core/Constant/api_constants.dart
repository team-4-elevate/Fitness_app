// ignore_for_file: file_names

class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://fitness.elevateegy.com/api/v1';
  static const String loginEndpoint = '/auth/signin';
  static const String forgotPasswordEndpoint = '/auth/forgotPassword';
  static const String verifyOtpEndpoint = '/auth/verifyResetCode';
  static const String resetPasswordEndpoint = '/auth/resetPassword';
  static const String registerEndpoint = '/auth/signup';
  static const String levelsEndpoint =
      '/levels/difficulty-levels/by-prime-mover';
  static const String primeMoverValue = '67c8499726895f87ce0aa9bc';
}
