import 'dart:io';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_interface.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repo/editprofile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSourceInterface remoteDataSource;

  EditProfileRepoImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<EditProfileResponse>> editProfileData({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  }) async {
    try {
      final result = await remoteDataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      );
      return ApiSuccess(result);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<ApiResult<EditProfileResponse>> getProfileData() async {
    try {
      final result = await remoteDataSource.getProfileData();
      return ApiSuccess(result);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<ApiResult<UploadImageResponse>> uploadProfileImage(
      File imageFile) async {
    try {
      final result = await remoteDataSource.uploadProfileImage(imageFile);
      return ApiSuccess(result);
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }
}
