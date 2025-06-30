import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_interface.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePasswordRemoteDsInterface)
class UpdatePasswordRemoteDsImpl implements UpdatePasswordRemoteDsInterface {
  final ApiClient _apiClient;
  UpdatePasswordRemoteDsImpl(this._apiClient);

  @override
  Future<void> updatePassword(UpdatePasswordRequest request) async {
    await _apiClient.put(
      ApiConstants.updatePasswordEndpoint,
      data: request.toJson(),
      requiresToken: true);
  }
}
