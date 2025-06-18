import 'user.dart';

class RegisterResponse {
  String? message;
  User? user;
  String? token;

  RegisterResponse({this.message, this.user, this.token});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      user:
          json['user'] == null
              ? null
              : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'user': user?.toJson(),
    'token': token,
  };
}
