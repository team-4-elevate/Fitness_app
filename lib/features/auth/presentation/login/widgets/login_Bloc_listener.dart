// features/auth/presentation/login/widgets/login_Bloc_listener.dart
import 'package:fitness_app/core/app_data/app_bloc.dart';
import 'package:fitness_app/core/app_data/app_events.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:flutter/foundation.dart'; // For debugPrint
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/animated_dialogs.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/login/login_state.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocListener extends StatelessWidget {
  final Widget child;
  const LoginBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginState>(
      listenWhen: (previous, current) {
        return (previous.showSocialLoginMessage !=
                    current.showSocialLoginMessage &&
                current.showSocialLoginMessage) ||
            (previous.navigateToResetPassword !=
                    current.navigateToResetPassword &&
                current.navigateToResetPassword) ||
            (previous.navigateToSignUp != current.navigateToSignUp &&
                current.navigateToSignUp) ||
            (previous.loginState != current.loginState);
      },
      listener: (context, state) async {
        final loginViewModel = context.read<LoginViewModel>();

        if (state.showSocialLoginMessage) {
          loginViewModel.loginIntent(LoginIntent.resetSocialMessage);

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
          loginViewModel.loginIntent(LoginIntent.resetNavigationFlags);
          Navigator.pushNamed(context, AppRoutes.forgotPass);
          return;
        }

        if (state.navigateToSignUp) {
          loginViewModel.loginIntent(LoginIntent.resetNavigationFlags);
          Navigator.pushReplacementNamed(context, AppRoutes.registerPage);
          return;
        }

        await state.loginState?.whenOrNull(
          loading: () {
            context.showLoadingIndicator();
          },
          success: (data) async {
            context.pop();
            if (data?.user != null) {
              final appBloc = context.read<AppBloc>();
              appBloc.add(CacheUserDataEvent(data!.user!));
            }
            await context.showSuccessNotification(
              title: context.l10n.login_successTitle,
              message: context.l10n.login_successMessage(
                data?.user?.firstName ?? '',
              ),
              onAnimationComplete: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.layoutScreen,
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
              },
            );
          },
        );
      },
      child: child,
    );
  }
}
