import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
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
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);
  @override
  Future<ApiResult<LoginResponse>> login(LoginRequest loginRequest) async {
    var response = await _apiClient.post(
      ApiConstants.loginEndpoint,
      data: loginRequest.toJson(),
    );
    return response.map((data) {
      return LoginResponse.fromJson(data);
    });
  }

  @override
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );

      return response.map((data) => RegisterResponse.fromJson(data));
    } catch (e) {
      return ApiFailure('Failed to register: $e');
    }
  }
  
  @override
  Future<ApiResult<ForgetpasswordResponse>> forgotPassword(ForgetpasswordRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.forgotPasswordEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );
      
      return response.map((data) => ForgetpasswordResponse.fromJson(data));
    } catch (e) {
      return ApiFailure('Failed to initiate forgot password: $e');
    }
  }

  @override
  Future<ApiResult<VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.verifyOtpEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );
      
      return response.map((data) => VerifyOtpResponse.fromJson(data));
    } catch (e) {
      return ApiFailure('Failed to verify OTP: $e');
    }
  }

  @override
  Future<ApiResult<ResetpasswordResponse>> resetPassword(ResetpasswordRequest request) async {
    try {
      final response = await _apiClient.put(
        ApiConstants.resetPasswordEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );
      
      return response.map((data) => ResetpasswordResponse.fromJson(data));
    } catch (e) {
      return ApiFailure('Failed to reset password: $e');
    }
  }
}
