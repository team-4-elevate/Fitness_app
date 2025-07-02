// features/edit_profile/domain/models/edit_profile/edit_profile_response.dart
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';


class EditProfileResponse {
  String? message;
  User? user;

  EditProfileResponse({this.message, this.user});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
      };
}
