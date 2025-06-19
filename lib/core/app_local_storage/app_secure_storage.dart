abstract interface class AppSecureStorage {
  Future<void> saveUserData(String key, dynamic value);
  Future<String?> getUserData(String key);
  Future<void> removeUserData(String key);
  Future<void> clearAllData();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
  Future<void> saveUserId(String userId);
  Future<bool> saveRememberMe(bool value);
  Future<String?> getUserId();
  Future<void> removeUserId();
  Future<bool> getRememberMe();
  Future<void> setLanguage(String languageCode);
  Future<String?> getLanguage();
}
