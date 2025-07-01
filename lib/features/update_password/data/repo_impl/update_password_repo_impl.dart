import 'dart:developer';

import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_request.dart';
import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_interface.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/repo_interface/update_password_repo_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdatePasswordRepoInterface)
class UpdatePasswordRepoImpl implements UpdatePasswordRepoInterface {
  final AuthLocalDataSourceContract _localDs;
  final UpdatePasswordRemoteDsInterface _remoteDs;

  UpdatePasswordRepoImpl(this._remoteDs, this._localDs);

  @override
  Future<void> updatePassword(UpdatePasswordRequest request) async {
    final apiRes = await _remoteDs.updatePassword(request);
    apiRes.when(
        success: (response) async {
          response.token?.isNotEmpty == true
              ? await _localDs.cacheToken(response.token!)
              : throw (ApiFailure(AppConstants.nullTokenMsg));
        },
        failure: (err) => throw (ApiFailure(err)));
  }
}
