import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/animated_dialogs.dart';
import 'package:fitness_app/features/auth/presentation/login/login_state.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:fitness_app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;
  const LoginBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginState>(
      listener: (context, state) async {
        final viewModel = context.read<LoginViewModel>();
        if (state.showSocialLoginMessage) {
          await context.showFailureNotification(
            title: 'Social Login',
            message: 'Social login is not implemented yet.',
            customization: DialogCustomization(messageColor: AppColors.black),
          );
          viewModel.resetStates();
          return;
        }

        if (state.navigateToResetPassword) {
          Navigator.pushNamed(context, AppRoutes.resetPasswordPage);
          viewModel.resetStates();
          return;
        }

        if (state.navigateToSignUp) {
          Navigator.pushNamed(context, AppRoutes.signUpPage);
          viewModel.resetStates();
          return;
        }
        await state.loginState?.whenOrNull(
          loading: () {
            context.showLoadingIndicator();
          },
          success: (data) async {
            context.pop();
            await context.showSuccessNotification(
              title: 'Login Successful',
              message: 'Welcome back, ${data?.user?.firstName ?? "User"}!',
              onAnimationComplete: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Home()),
                  (route) => false,
                );
              },
            );
          },
          error: (error) async {
            context.pop();
            await context.showFailureAction(
              title: 'Login Failed',
              message: error ?? 'An unexpected error occurred.',
              buttonText: 'Ok Got it',
              onButtonPressed: () {
                context.pop();
                viewModel.resetStates();
              },
            );
          },
        );
      },
      child: child,
    );
  }
}
