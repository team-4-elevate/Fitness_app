import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AppLocalStorage)
class AppLocalStorageImpl implements AppLocalStorage {
  final SharedPreferences _sharedPreferences;

  AppLocalStorageImpl(this._sharedPreferences);

  @override
  Future<void> setShowOnboarding(bool value) async {
    try {
      await _sharedPreferences.setBool(AppKeys.showOnboarding, value);
      dev.log('Set User is Show Onboarding : $value', name: 'AppLocalStorage');
    } catch (e) {
      dev.log(
        'Error Set User is Show Onboarding : $value',
        error: e,
        name: 'AppLocalStorage',
      );
      rethrow;
    }
  }

  @override
  Future<bool> isShowOnboarding() async {
    try {
      return _sharedPreferences.getBool(AppKeys.showOnboarding) ?? false;
    } catch (e) {
      dev.log('Error getting User is Show Onboarding', error: e);
      rethrow;
    }
  }
}
