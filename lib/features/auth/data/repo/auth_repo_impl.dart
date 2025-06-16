// features/auth/data/repo/auth_repo_impl.dart

import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/register/register_request.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fitness_app/features/auth/domain/entities/register_details.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final ApiClient _apiClient;
  
  AuthRepoImpl(this._apiClient);
  


  //-------------------------register-------------------------
  @override
  Future<ApiResult<RegisterResponse>> register(RegisterDetailsData data) async {
    try {
      final request = RegisterRequest(
        firstName: data.firstName,
        lastName: data.lastName,
        email: data.email,
        password: data.password,
        rePassword: data.rePassword,
        gender: data.gender?.name,
        height: data.height,
        weight: data.weight,
        age: data.age,
        goal: data.goal,
        activityLevel: data.activityLevel,
      );
      
      final result = await _apiClient.post<Map<String, dynamic>>(
        ApiConstants.registerEndpoint,
        data: request.toJson(),
        requiresToken: false,
      );
      
      return result.map((data) => RegisterResponse.fromJson(data));
    } catch (e) {
      debugPrint('Registration repository error: $e');
      return ApiFailure('Failed to register: $e');
    }
  }
}
