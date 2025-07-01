import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/repo_interface/update_password_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePasswordUseCase {
  final UpdatePasswordRepoInterface _repo;
  UpdatePasswordUseCase(this._repo);

  Future<void> call(UpdatePasswordRequest request) async {
    return await _repo.updatePassword(request);
  }
}
