import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDs _remoteDs;
  final AppSecureStorage _appSecureStorage;
  ProfileRepoImpl(this._remoteDs, this._appSecureStorage);
  @override
  Future<ApiResult<void>> logout() async {
    var result = await _remoteDs.logout();
    if (result.isSuccess) {
      await _appSecureStorage.clearAllData();
    }
    return result;
  }
}
