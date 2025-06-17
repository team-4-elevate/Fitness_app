// features/auth/domain/repo/auth_repo.dart

import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';

abstract class AuthRepo {

  //-------------------------register-------------------------
  Future<ApiResult<RegisterResponse>> register(RegisterDetailsData data);
}