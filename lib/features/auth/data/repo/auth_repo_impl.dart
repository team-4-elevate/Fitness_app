// features/auth/data/repo/auth_repo_impl.dart

import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract _remoteDataSource;

  AuthRepoImpl(this._remoteDataSource);

  //-------------------------register-------------------------
  @override
  Future<ApiResult<RegisterResponse>> register(RegisterDetailsData data) async {
    try {
      final request = data.toRegisterRequest();

      return await _remoteDataSource.register(request);
    } catch (e) {
      debugPrint('Registration repository error: $e');
      return ApiFailure('Failed to register: $e');
    }
  }
}
