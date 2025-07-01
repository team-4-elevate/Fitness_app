// features/edit_profile/domain/usecases/upload_profile_image_usecase.dart
import 'dart:io';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repo/repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UploadProfileImageUseCase {
  final Repo _repo;

  UploadProfileImageUseCase(this._repo);

  Future<ApiResult<UploadImageResponse>> call(File imageFile) {
    return _repo.uploadProfileImage(imageFile);
  }
}
