import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo _repo;
  LoginUseCase(this._repo);

  Future<ApiResult<LoginResponse>> call(LoginRequest loginRequest) async{
    return await _repo.login(loginRequest);
  }
}
