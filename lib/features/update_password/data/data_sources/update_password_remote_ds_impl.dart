import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_interface.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePasswordRemoteDsInterface)
class UpdatePasswordRemoteDsImpl implements UpdatePasswordRemoteDsInterface {
  final ApiClient _apiClient;
  UpdatePasswordRemoteDsImpl(this._apiClient);

  @override
  Future<ApiResult<ResetPasswordResponse>> updatePassword(
      UpdatePasswordRequest request) async {
    final res = await _apiClient.patch(ApiConstants.updatePassEndpoint,
        data: request.toJson(), requiresToken: true);
    if (res.isFailure) throw ((res as ApiFailure).message);
    return res.map((json) => ResetPasswordResponse.fromJson(json));
  }
}
