// core/services/navigation_service.dart


class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  
  factory NavigationService() => _instance;
  
  NavigationService._internal();
  
  Function(int)? tabNavigationCallback;
  
  void registerTabNavigationCallback(Function(int) callback) {
    tabNavigationCallback = callback;
  }
  
  void navigateToTab(int index) {
    if (tabNavigationCallback != null) {
      tabNavigationCallback!(index);
    }
  }
}
