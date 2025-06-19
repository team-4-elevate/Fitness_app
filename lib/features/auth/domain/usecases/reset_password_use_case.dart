import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repo;
  ResetPasswordUseCase(this._repo);

  Future<void> call(ResetpasswordRequest request) async {
    await _repo.resetPassword(request);
  }
}
