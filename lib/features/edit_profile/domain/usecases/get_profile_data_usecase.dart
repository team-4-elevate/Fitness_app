import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repo/editprofile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileDataUseCase {
  final EditProfileRepo _repository;

  GetProfileDataUseCase(this._repository);

  Future<ApiResult<EditProfileResponse>> call() async {
    return await _repository.getProfileData();
  }
}
