import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/blurred_container.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/login/login_state.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginViewModel, LoginState>(
      builder: (context, state) {
        return Form(
          key: viewModel.formKey,
          child: BlurredContainer(
            child: Column(
              children: [
                Text(
                  context.l10n.login_title,
                  style: AppFontStyle.customAppFont.copyWith(fontSize: 24.sp),
                ).center,
                R.spaceH16,
                TextFormField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                  onChanged:
                      (_) => viewModel.loginIntent(LoginIntent.validateEmail),
                  decoration: InputDecoration(
                    labelText: context.l10n.login_emailLabel,
                    hintText: context.l10n.login_emailHint,
                    errorText: state.emailError,
                  ),
                ),
                R.spaceH16,
                ValueListenableBuilder<bool>(
                  valueListenable: viewModel.isPasswordVisible,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: viewModel.passwordController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      keyboardType: TextInputType.visiblePassword,
                      onChanged:
                          (_) => viewModel.loginIntent(
                            LoginIntent.validatePassword,
                          ),
                      decoration: InputDecoration(
                        labelText: context.l10n.login_passwordLabel,
                        hintText: context.l10n.login_passwordHint,
                        errorText: state.passwordError,
                        suffixIcon: Icon(
                          viewModel.isPasswordVisible.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                        ).onTap(() {
                          viewModel.loginIntent(
                            LoginIntent.changePasswordVisibility,
                          );
                        }),
                      ),
                      obscureText: viewModel.isPasswordVisible.value,
                    );
                  },
                ),
                SizedBox(height: R.spaceMD),
                Text(
                  context.l10n.login_forgotPassword,
                  style: AppFontStyle.customAppFont.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryOrange,
                    decorationThickness: 1.5.r,
                    color: AppColors.primaryOrange,
                  ),
                ).align(Alignment.centerRight).onTap(() {
                  viewModel.loginIntent(
                    LoginIntent.forgotPasswordButtonPressed,
                  );
                }),
                Row(
                  children: [
                    Divider(
                      color: AppColors.white.withOpacity(0.5),
                      thickness: 1.5,
                      endIndent: 10.w,
                      indent: 20.w,
                    ).expanded,
                    Text(
                      context.l10n.login_orDivider,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.5),
                      ),
                    ),
                    Divider(
                      color: AppColors.white.withOpacity(0.5),
                      thickness: 1.5,
                      endIndent: 10.w,
                      indent: 20.w,
                    ).expanded,
                  ],
                ),
                R.spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(BoxIcons.bxl_facebook_circle, size: 30.sp).onTap(() {
                      viewModel.loginIntent(
                        LoginIntent.socialLoginButtonPressed,
                      );
                    }),
                    R.spaceW16,
                    Icon(BoxIcons.bxl_google, size: 30.sp).onTap(() {
                      viewModel.loginIntent(
                        LoginIntent.socialLoginButtonPressed,
                      );
                    }),
                    R.spaceW16,
                    Icon(BoxIcons.bxl_apple, size: 30.sp).onTap(() {
                      viewModel.loginIntent(
                        LoginIntent.socialLoginButtonPressed,
                      );
                    }),
                  ],
                ),
                R.spaceH16,
                ElevatedButton(
                  onPressed:
                      state.isFormValid
                          ? () async {
                            viewModel.loginIntent(
                              LoginIntent.loginButtonPressed,
                            );
                          }
                          : null,
                  child: Text(
                    context.l10n.login_title,
                    style: AppFontStyle.customAppFont.copyWith(fontSize: 18.sp),
                  ),
                ),
                R.spaceH8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.login_noAccount,
                      style: AppFontStyle.customAppFont.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      context.l10n.login_register,
                      style: AppFontStyle.customAppFont.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.primaryOrange,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryOrange,
                        decorationThickness: 1.5,
                      ),
                    ).onTap(
                      () => viewModel.loginIntent(
                        LoginIntent.registerButtonPressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
