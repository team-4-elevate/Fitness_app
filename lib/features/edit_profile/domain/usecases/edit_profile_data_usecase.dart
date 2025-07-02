import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repo/editprofile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileDataUseCase {
  final EditProfileRepo _repository;

  EditProfileDataUseCase(this._repository);

  Future<ApiResult<EditProfileResponse>> call({
    String? firstName,
    String? lastName,
    String? email,
    String? weight,
    String? goal,
    String? activityLevel,
  }) async {
    return await _repository.editProfileData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel,
    );
  }
}
