import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest);
}
