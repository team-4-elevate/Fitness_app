// core/app_local_storage/app_secure_storage_impl.dart
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as dev;

@Injectable(as: AppSecureStorage)
class AppSecureStorageImpl implements AppSecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // Storage keys

  @override
  Future<void> clearAllData() async {
    dev.log('Clearing all secure storage data', name: 'AppLocalStorage');
    try {
      await _secureStorage.deleteAll();
      dev.log(
        'All secure storage data cleared successfully',
        name: 'AppLocalStorage',
      );
    } catch (e) {
      dev.log(
        'Error clearing secure storage data',
        error: e,
        name: 'AppLocalStorage',
      );
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    dev.log('Getting auth token from secure storage', name: 'AppLocalStorage');
    try {
      final token = await _secureStorage.read(key: AppKeys.token);
      dev.log(
        'Auth token retrieved: ${token != null ? '[TOKEN EXISTS]' : 'null'}',
        name: 'AppLocalStorage',
      );
      return token;
    } catch (e) {
      dev.log('Error getting auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<String?> getUserData(String key) async {
    dev.log('Getting user data for key: $key', name: 'AppLocalStorage');
    try {
      final data = await _secureStorage.read(key: AppKeys.userData + key);
      dev.log(
        'User data retrieved for $key: ${data != null ? '[DATA EXISTS]' : 'null'}',
        name: 'AppLocalStorage',
      );
      return data;
    } catch (e) {
      dev.log(
        'Error getting user data for $key',
        error: e,
        name: 'AppLocalStorage',
      );
      rethrow;
    }
  }

  @override
  Future<String?> getUserId() async {
    dev.log('Getting user ID from secure storage', name: 'AppLocalStorage');
    try {
      final userId = await _secureStorage.read(key: AppKeys.userId);
      dev.log(
        'User ID retrieved: ${userId ?? 'null'}',
        name: 'AppLocalStorage',
      );
      return userId;
    } catch (e) {
      dev.log('Error getting user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> removeToken() async {
    dev.log('Removing auth token from secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: AppKeys.token);
      dev.log('Auth token removed successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error removing auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> removeUserData(String key) async {
    dev.log('Removing user data for key: $key', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: AppKeys.userData + key);
      dev.log(
        'User data for $key removed successfully',
        name: 'AppLocalStorage',
      );
    } catch (e) {
      dev.log(
        'Error removing user data for $key',
        error: e,
        name: 'AppLocalStorage',
      );
      rethrow;
    }
  }

  @override
  Future<void> removeUserId() async {
    dev.log('Removing user ID from secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.delete(key: AppKeys.userId);
      dev.log('User ID removed successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error removing user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    dev.log('Saving auth token to secure storage', name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: AppKeys.token, value: token);
      dev.log('Auth token saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving auth token', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<void> saveUserData(String key, dynamic value) async {
    dev.log('Saving user data: $key', name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: AppKeys.userData + key, value: value);
      dev.log('User data for $key saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log(
        'Error saving user data for $key',
        error: e,
        name: 'AppLocalStorage',
      );
      rethrow;
    }
  }

  @override
  Future<void> saveUserId(String userId) async {
    dev.log(
      'Saving user ID: $userId to secure storage',
      name: 'AppLocalStorage',
    );
    try {
      await _secureStorage.write(key: AppKeys.userId, value: userId);
      dev.log('User ID saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving user ID', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<bool> saveRememberMe(bool value) async {
    await _secureStorage.write(key: 'rememberMe', value: value.toString());
    return value;
  }

  @override
  Future<bool> getRememberMe() async {
    final value = await _secureStorage.read(key: 'rememberMe');
    if (value != null) {
      return value == 'true';
    } else {
      return false;
    }
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    dev.log('Saving language: $languageCode', name: 'AppLocalStorage');
    try {
      await _secureStorage.write(key: 'language', value: languageCode);
      dev.log('Language saved successfully', name: 'AppLocalStorage');
    } catch (e) {
      dev.log('Error saving language', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }

  @override
  Future<String?> getLanguage() async {
    dev.log('Getting language from secure storage', name: 'AppLocalStorage');
    try {
      final language = await _secureStorage.read(key: 'language');
      dev.log(
        'Language retrieved: ${language ?? 'null'}',
        name: 'AppLocalStorage',
      );
      return language;
    } catch (e) {
      dev.log('Error getting language', error: e, name: 'AppLocalStorage');
      rethrow;
    }
  }
}
