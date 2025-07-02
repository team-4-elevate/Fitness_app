class UpdatePasswordRequest {
  String? oldPassword;
  String? newPassword;

  UpdatePasswordRequest({this.oldPassword, this.newPassword});

  Map<String, dynamic> toJson() => {
        'password': oldPassword,
        'newPassword': newPassword,
      };
}
