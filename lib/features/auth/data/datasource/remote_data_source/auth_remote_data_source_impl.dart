// features/auth/data/datasource/remote_data_source/auth_remote_data_source_impl.dart

import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/register/register_request.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<RegisterResponse>> register(RegisterRequest request) async {
    try {
      debugPrint('Starting registration request...');
      final response = await _apiClient.post(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );

      return response.map((data) => RegisterResponse.fromJson(data));
    } catch (e) {
      debugPrint('Registration error: $e');
      return ApiFailure('Failed to register: $e');
    }
  }
}
