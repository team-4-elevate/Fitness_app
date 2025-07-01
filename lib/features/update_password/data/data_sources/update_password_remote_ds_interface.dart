import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';

abstract class UpdatePasswordRemoteDsInterface {
  Future<ApiResult<ResetPasswordResponse>> updatePassword(UpdatePasswordRequest request);
}
