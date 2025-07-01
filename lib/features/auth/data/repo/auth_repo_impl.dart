// features/auth/data/repo/auth_repo_impl.dart
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/core/helper/handel_repo_response.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_response.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_request.dart';
import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract _authRemoteDataSource;
  final AppSecureStorage _secureStorage;
  AuthRepoImpl(this._authRemoteDataSource, this._secureStorage);
  @override
  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      var response = await _authRemoteDataSource.login(loginRequest);
      return handleRepoResponse(response).thenDoAsync((data) async {
        await _secureStorage.saveToken(data.token ?? '');
      });
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }

  @override
  Future<ApiResult<RegisterResponse>> register(RegisterDetailsData data) async {
    try {
      final request = data.toRegisterRequest();
      return await _authRemoteDataSource.register(request);
    } catch (e) {
      return ApiFailure('Failed to register: $e');
    }
  }

  @override
  Future<void> forgotPassword(ForgetpasswordRequest request) async {
    await _authRemoteDataSource.forgotPassword(request);
  }

  @override
  Future<void> verifyOtp(VerifyOtpRequest request) async {
    await _authRemoteDataSource.verifyOtp(request);
  }

  @override
  Future<ApiResult<ResetPasswordResponse>> resetPassword(
    ResetpasswordRequest request,
  ) async {
    try {
      var response = await _authRemoteDataSource.resetPassword(request);
      return handleRepoResponse(response).thenDoAsync((data) async {
        if (data.token != null && data.token!.isNotEmpty) {
          await _secureStorage.saveToken(data.token!);
        }
      });
    } catch (e) {
      return ApiFailure('Failed to reset password: $e');
    }
  }
}
