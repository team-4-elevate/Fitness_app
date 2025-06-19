// features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_response.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_response.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/register/register_request.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';

abstract interface class AuthRemoteDataSourceContract {
  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest);
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request);

  Future<void> forgotPassword(ForgetpasswordRequest request);
  Future<void> verifyOtp(VerifyOtpRequest request);
  Future<ApiResult<ResetpasswordResponse>> resetPassword(
    ResetpasswordRequest request,
  );
}
