import 'dart:io';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';

abstract interface class EditProfileRepo {
  Future<ApiResult<EditProfileResponse>> getProfileData();
  Future<ApiResult<EditProfileResponse>> editProfileData({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  });

  Future<ApiResult<UploadImageResponse>> uploadProfileImage(File imageFile);
}
