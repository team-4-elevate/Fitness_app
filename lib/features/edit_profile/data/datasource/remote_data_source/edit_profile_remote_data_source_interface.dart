// features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_interface.dart
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';

abstract class EditProfileRemoteDataSourceInterface {
  Future<EditProfileResponse> getProfileData();
  Future<EditProfileResponse> editProfileData({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  });
}
