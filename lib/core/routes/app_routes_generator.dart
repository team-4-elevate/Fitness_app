import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (_) =>  OnBoardingPage(),
        );
      
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
