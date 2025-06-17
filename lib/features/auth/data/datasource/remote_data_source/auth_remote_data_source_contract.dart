// features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/register/register_request.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request);
}
