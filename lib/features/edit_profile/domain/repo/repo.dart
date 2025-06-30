// features/edit_profile/domain/repo/repo.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';

abstract interface class Repo {
  Future<ApiResult<EditProfileResponse>> getProfileData();
  Future<ApiResult<EditProfileResponse>> editProfileData({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  });
}
