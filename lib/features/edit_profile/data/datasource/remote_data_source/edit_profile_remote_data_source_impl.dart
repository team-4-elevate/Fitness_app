// features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_impl.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_interface.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:injectable/injectable.dart';
import 'package:http_parser/http_parser.dart';

@Injectable(as: EditProfileRemoteDataSourceInterface)
class EditProfileRemoteDataSourceImpl
    extends EditProfileRemoteDataSourceInterface {
  final ApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<EditProfileResponse> editProfileData({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  }) async {
   
    final Map<String, dynamic> payload = {};

    if (firstName != null) payload[AppKeys.firstName] = firstName;
    if (lastName != null) payload[AppKeys.lastName] = lastName;
    if (email != null) payload[AppKeys.email] = email;
    if (weight != null) payload[AppKeys.weight] = weight;
    if (goal != null) payload[AppKeys.goal] = goal;
    if (activityLevel != null) payload[AppKeys.activityLevel] = activityLevel;

    final apiResult = await _apiClient.put(
      ApiConstants.editprofileEndpoint,
      data: payload,
    );

    final responseData = apiResult.dataOrNull;
    if (responseData == null) {
      throw Exception('Failed to edit profile: No data returned from server');
    }
    return EditProfileResponse.fromJson(responseData as Map<String, dynamic>);
  }

  @override
  Future<EditProfileResponse> getProfileData() async {
    final apiResult = await _apiClient.get(ApiConstants.getprofileEndpoint);
    final responseData = apiResult.dataOrNull;
    if (responseData == null) {
      throw Exception('Failed to get profile data');
    }
    return EditProfileResponse.fromJson(responseData as Map<String, dynamic>);
  }

  @override
  Future<UploadImageResponse> uploadProfileImage(File imageFile) async {
    try {
      final formData = FormData();
      String fileName = imageFile.path.split('/').last;

      String extension = fileName.split('.').last.toLowerCase();
      String contentType;

      if (extension == 'jpg' || extension == 'jpeg') {
        contentType = 'image/jpeg';
      } else if (extension == 'png') {
        contentType = 'image/png';
      } else if (extension == 'gif') {
        contentType = 'image/gif';
      } else {
        contentType = 'application/octet-stream';
      }

      final multipartFile = await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
        contentType: MediaType.parse(contentType),
      );

      formData.files.add(MapEntry('photo', multipartFile));

      final apiResult = await _apiClient.put(
        ApiConstants.uploadProfilePhotoEndpoint,
        data: formData,
        requiresToken: true,
      );

      final responseData = apiResult.dataOrNull;
      if (responseData == null) {
        throw Exception('Failed to upload profile image');
      }
      return UploadImageResponse.fromJson(responseData as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
