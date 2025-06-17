// core/routes/app_routes_generator.dart
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:fitness_app/features/home/home.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;
import 'package:flutter_bloc/flutter_bloc.dart';



class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //--------------------------------------------register--------------------
      case AppRoutes.registerPage:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.registerDetailsView:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => BlocProvider<RegisterBloc>.value(
            value: args?['registerBloc'],
            child: RegisterDetailsView(
              initialData: args?['userData'],
            ),
          ),
        );



        //--------------------------------------------home page--------------------
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const Home());
        
        //////--------------------------------------------login--------------------
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
