class EditProfileRequest {
  String? lastName;

  EditProfileRequest({this.lastName});

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) {
    return EditProfileRequest(
      lastName: json['lastName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'lastName': lastName,
      };
}
