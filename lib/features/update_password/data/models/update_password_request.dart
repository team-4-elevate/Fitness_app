class UpdatePasswordRequest {
  String? email;
  String? oldPassword;
  String? newPassword;

  UpdatePasswordRequest({this.email, this.oldPassword, this.newPassword});

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordRequest(
      email: json['email'] as String?,
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };
} 