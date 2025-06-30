// features/edit_profile/data/datasource/local_data_source/edit_profile_local_data_source_impl.dart

import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/features/edit_profile/data/datasource/local_data_source/edit_profile_local_data_source_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileLocalDataSourceInterface)
class EditProfileLocalDataSourceImpl
    implements EditProfileLocalDataSourceInterface {
  final AppSecureStorage _localStorageClient;

  EditProfileLocalDataSourceImpl(this._localStorageClient);

  @override
  Future<void> deleteToken() async {
    await _localStorageClient.removeUserData('token');
  }
}
