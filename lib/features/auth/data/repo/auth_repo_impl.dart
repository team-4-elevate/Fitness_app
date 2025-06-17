import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/core/helper/handel_repo_response.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
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
      return handleRepoResponse(response).thenDo((data) async {
        await _secureStorage.saveToken(data.token ?? '');
      });
    } catch (e) {
      return ApiFailure(e.toString());
    }
  }
}
