// core/routes/app_routes_generator.dart
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:fitness_app/features/food/presentation/pages/food_page.dart';
import 'package:fitness_app/features/home/home.dart';
import 'package:fitness_app/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/forget_password/bloc/forget_password_bloc.dart';
import '../../features/auth/presentation/forget_password/view/create_new_password/create_new_password_page.dart';
import '../../features/auth/presentation/forget_password/view/forget_password_view/forget_password_page.dart';
import '../../features/auth/presentation/forget_password/view/otp_code_view/otp_code_page.dart';

class AppRoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.loginPage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<LoginViewModel>(
                create: (_) => getIt<LoginViewModel>(),
                child: const LoginView(),
              ),
        );
      case AppRoutes.registerPage:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<RegisterBloc>(
                create: (context) => getIt<RegisterBloc>(),
                child: const RegisterView(),
              ),
        );
      case AppRoutes.registerDetailsView:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => BlocProvider<RegisterBloc>.value(
                value: args?['registerBloc'],
                child: RegisterDetailsView(initialData: args?['userData']),
              ),
        );

      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (_) => const Home());

      case AppRoutes.forgotPass:
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => BlocProvider(
                create: (_) => getIt<ForgetPasswordBloc>(),
                child: const ForgetPasswordPage(),
              ),
        );
      case AppRoutes.forgetPassOtpPage:
        final args = settings.arguments as ForgetPasswordBloc;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return BlocProvider.value(
              value: args,
              child: ForgetPassOtpCodePage(bloc: args),
            );
          },
        );
      case AppRoutes.createNewPasswordPage:
        final args = settings.arguments as ForgetPasswordBloc;
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: args,
              child: CreateNewPasswordPage(bloc: args),
            );
          },
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());

      case AppRoutes.foodPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return FoodPage();
          },
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
