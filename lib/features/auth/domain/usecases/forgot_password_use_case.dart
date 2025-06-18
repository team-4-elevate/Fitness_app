import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordUseCase {
  final AuthRepo _repo;
  ForgotPasswordUseCase(this._repo);

  Future<ApiResult<ForgetpasswordResponse>> call(
    ForgetpasswordRequest request,
  ) async {
    return await _repo.forgotPassword(request);
  }
}
