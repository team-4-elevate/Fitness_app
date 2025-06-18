import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepo _repo;
  VerifyOtpUseCase(this._repo);

  Future<ApiResult<VerifyOtpResponse>> call(VerifyOtpRequest request) async {
    return await _repo.verifyOtp(request);
  }
}
