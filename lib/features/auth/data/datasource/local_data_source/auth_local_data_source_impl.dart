// features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart

import 'dart:developer';

import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:injectable/injectable.dart';

// import '../../../../../core/logger/app_logger.dart';

@Injectable(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final AppSecureStorage _localStorageClient;

  AuthLocalDataSourceImpl(this._localStorageClient);

  //-----------------------------Token-----------------------------------
  @override
  Future<void> cacheToken(String token) async {
    await _localStorageClient.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return await _localStorageClient.getToken();
  }

  @override
  Future<void> deleteToken() async {
    await _localStorageClient.removeToken();
  }

  @override
  Future<String?> checkSavedToken() async {
    try {
      return await _localStorageClient.getToken();
    } catch (e) {
      log('Error checking saved token: $e');
      return null;
    }
  }

  //-----------------------------RememberMe-----------------------------------
  @override
  Future<void> cacheRememberMe(bool rememberMe) async {
    await _localStorageClient.saveRememberMe(rememberMe);
  }

  @override
  bool getRememberMe() {
    final value = _localStorageClient.getRememberMe();
    return true;
  }

  @override
  Future<void> deleteRememberMe() async {
    await _localStorageClient.removeUserData('rememberMe');
  }
}
