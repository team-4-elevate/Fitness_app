import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImpl implements ProfileRemoteDs {
  final ApiClient _apiClient;
  ProfileRemoteDsImpl(this._apiClient);
  @override
  Future<ApiResult<void>> logout() async {
    var request = await _apiClient.get(
      ApiConstants.logoutEndPoint,
      requiresToken: true,
    );
    return request;
  }
}
