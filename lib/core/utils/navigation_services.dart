import 'package:flutter/material.dart'
    show
        GlobalKey,
        MaterialPageRoute,
        NavigatorState,
        Route,
        RoutePredicate,
        Widget;
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get navigator => navigatorKey.currentState;
  NavigatorState get currentRouteName => navigatorKey.currentState!;

  Future<T?> push<T>(Route<T> route) {
    return navigator!.push(route);
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator!.pushNamed(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigator!.pushReplacementNamed(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return navigator!.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) {
    navigator!.pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    navigator!.popUntil(predicate);
  }

  bool canPop() {
    return navigator!.canPop();
  }

  void goBack<T>([T? result]) {
    if (canPop()) {
      pop(result);
    }
  }

  void popToRoot() {
    navigator!.popUntil((route) => route.isFirst);
  }

  Future<bool> maybePop<T>([T? result]) {
    return navigator!.maybePop(result);
  }

  Route<T> materialRoute<T>(Widget page) {
    return MaterialPageRoute<T>(builder: (_) => page);
  }
}
