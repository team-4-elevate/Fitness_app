// core/routes/app_routes_generator.dart
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/features/app_sections/AppSections.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:fitness_app/features/exercise/domain/arguments/exercise_page_arguments.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_event.dart';
import 'package:fitness_app/features/exercise/presentation/view/exercise_page/exercise_page.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/features/food_recommendation/presentation/pages/food_recommendation_screen.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/home/presentation/pages/home.dart';
import 'package:fitness_app/features/home/presentation/widgets/upcoming-workout_tapbar.dart';
import 'package:fitness_app/features/food_details/presentation/pages/food_details_page.dart';
import 'package:fitness_app/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/pages/upcoming_workout_screen.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/view/update_password_page.dart';
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
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => getIt<LoginViewModel>(),
            child: const LoginView(),
          ),
        );
      case AppRoutes.registerPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<RegisterBloc>(
            create: (context) => getIt<RegisterBloc>(),
            child: const RegisterView(),
          ),
        );
      case AppRoutes.registerDetailsView:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<RegisterBloc>.value(
            value: args?['registerBloc'],
            child: RegisterDetailsView(initialData: args?['userData']),
          ),
        );

      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>(
            create: (_) => getIt<HomeBloc>(),
            child: const Home(),
          ),
        );

      case AppRoutes.layoutScreen:
        return MaterialPageRoute(builder: (_) => MainNavigationScreen());

      case AppRoutes.forgotPass:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
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
      case AppRoutes.updatePasswordPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<UpdatePasswordBloc>(),
            child: const UpdatePasswordPage(email: 'omar0elsaid00@gmail.com',),
          ),
        );
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case AppRoutes.foodDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => FoodDetailsPage(
            args: settings.arguments as FoodDetailsArgs,
          ),
        );

      case AppRoutes.foodRecommendationScreen:
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedTabIndex = args?['selectedTabIndex'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<FoodRecommendationViewModel>(),
            child: FoodRecommendationScreen(
              selectedTabIndex: selectedTabIndex,
            ),
          ),
        );

      case AppRoutes.exercisePage:
        return MaterialPageRoute(
          builder: (_) {
            final args = settings.arguments as ExercisePageArguments;
            return BlocProvider(
              create: (context) {
                return getIt<ExercisePageBloc>()..add(GetLevelsEvent());
              },
              child: ExercisePage(arguments: args),
            );
          },
        );
      case AppRoutes.upcomingWorkoutTabBar:
        return MaterialPageRoute(builder: (_) => const UpcomingWorkoutTabBar());

      case AppRoutes.upcomingWorkoutSeeallPage:
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedTabIndex = args?['selectedTabIndex'] as int?;

        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeBloc>(
            create: (_) => getIt<HomeBloc>()..add(const LoadHomeData()),
            child: UpComingWorkoutScreen(selectedTabIndex: selectedTabIndex),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
