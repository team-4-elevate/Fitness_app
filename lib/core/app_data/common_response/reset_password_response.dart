class ResetPasswordResponse {
  String? message;
  String? token;

  ResetPasswordResponse({this.message, this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }
}
