class UpdatePasswordResponse {
  String? message;
  String? token;

  UpdatePasswordResponse({this.message, this.token});

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'message': message, 'token': token};
} 