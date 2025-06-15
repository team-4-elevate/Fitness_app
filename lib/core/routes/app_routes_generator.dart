// core/routes/app_routes_generator.dart
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //--------------------------------------------register--------------------
      case AppRoutes.registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.registerDetailsView:
        return MaterialPageRoute(builder: (_) => const RegisterDetailsView());
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
