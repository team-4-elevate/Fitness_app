abstract interface class AppLocalStorage {
  Future<void> setShowOnboarding(bool value);
  Future<bool> isShowOnboarding();
}
