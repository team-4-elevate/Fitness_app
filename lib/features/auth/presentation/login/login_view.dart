import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/blurred_background.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:fitness_app/features/auth/presentation/login/widgets/login_Bloc_listener.dart';
import 'package:fitness_app/features/auth/presentation/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginViewModel>();
    return Scaffold(
      body: LoginBlocListener(
        child: BlurredBackground(
          isScrollable: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppConstants.appLogo,
                width: 80.w,
                height: 55.h,
              ).center.paddingOnly(top: 40.h),
              R.spaceH24,
              Text(
                context.l10n.login_heyThere,
                style: AppFontStyle.customAppFont.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ).paddingOnly(left: R.paddingSMValue),
              R.spaceH4,
              Text(
                context.l10n.login_welcomeBack,
                style: AppFontStyle.customAppFont.copyWith(fontSize: 20.sp),
              ).paddingOnly(left: R.paddingSMValue),
              R.spaceH24,
              LoginForm(viewModel: viewModel),
            ],
          ),
        ),
      ),
    );
  }
}
