import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_interface.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/repo_interface/update_password_repo_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePasswordRepoInterface)
class UpdatePasswordRepoImpl implements UpdatePasswordRepoInterface {
  final UpdatePasswordRemoteDsInterface _remoteDsInterface;
  UpdatePasswordRepoImpl(this._remoteDsInterface);

  @override
  Future<void> updatePassword(UpdatePasswordRequest request) async {
    await _remoteDsInterface.updatePassword(request);
  }
} 