// features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_impl.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fitness_app/core/Constant/api_constants.dart';
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
    // Create payload with only non-null values
    final Map<String, dynamic> payload = {};

    if (firstName != null) payload['firstName'] = firstName;
    if (lastName != null) payload['lastName'] = lastName;
    if (email != null) payload['email'] = email;
    if (weight != null) payload['weight'] = weight;
    if (goal != null) payload['goal'] = goal;
    if (activityLevel != null) payload['activityLevel'] = activityLevel;

    final apiResult = await _apiClient.put(
      ApiConstants.editprofileEndpoint,
      data: payload,
    );

    final responseData = apiResult.dataOrNull as Map<String, dynamic>;
    return EditProfileResponse.fromJson(responseData);
  }

  @override
  Future<EditProfileResponse> getProfileData() async {
    final apiResult = await _apiClient.get(ApiConstants.getprofileEndpoint);
    final responseData = apiResult.dataOrNull as Map<String, dynamic>;
    return EditProfileResponse.fromJson(responseData);
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

      final responseData = apiResult.dataOrNull as Map<String, dynamic>;
      return UploadImageResponse.fromJson(responseData);
    } catch (e) {
      print('Error uploading profile image: $e');
      rethrow;
    }
  }
}
