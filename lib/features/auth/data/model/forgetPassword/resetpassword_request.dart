class ResetpasswordRequest {
  String? email;
  String? newPassword;

  ResetpasswordRequest({this.email, this.newPassword});

  factory ResetpasswordRequest.fromJson(Map<String, dynamic> json) {
    return ResetpasswordRequest(
      email: json['email'] as String?,
      newPassword: json['newPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'newPassword': newPassword};
}
