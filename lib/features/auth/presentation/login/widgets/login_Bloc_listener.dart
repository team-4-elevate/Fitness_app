import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/animated_dialogs.dart';
import 'package:fitness_app/features/app_sections/AppSections.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
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
          await context.showFailureAction(
            buttonText: context.l10n.login_socialButton,
            onButtonPressed: () {
              context.pop();
            },
            title: context.l10n.login_socialTitle,
            message: context.l10n.login_socialMessage,
            customization: DialogCustomization(messageColor: AppColors.black),
          );
          return;
        }

        if (state.navigateToResetPassword) {
          Navigator.pushNamed(context, AppRoutes.forgotPass);
          viewModel.loginIntent(LoginIntent.resetStates);
          return;
        }

        if (state.navigateToSignUp) {
          Navigator.pushReplacementNamed(context, AppRoutes.registerPage);
          return;
        }
        await state.loginState?.whenOrNull(
          loading: () {
            context.showLoadingIndicator();
          },
          success: (data) async {
            context.pop();
            await context.showSuccessNotification(
              title: context.l10n.login_successTitle,
              message: context.l10n.login_successMessage(
                data?.user?.firstName ?? '',
              ),
              onAnimationComplete: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => MainNavigationScreen()),
                  (route) => false,
                );
              },
            );
          },
          error: (error) async {
            context.pop();
            await context.showFailureAction(
              title: context.l10n.login_failedTitle,
              message: error ?? '',
              buttonText: context.l10n.login_failedButton,
              onButtonPressed: () {
                context.pop();
                viewModel.loginIntent(LoginIntent.resetStates);
              },
            );
          },
        );
      },
      child: child,
    );
  }
}
