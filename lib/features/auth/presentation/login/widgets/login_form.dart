import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/theme/app_font_style.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/core/widgets/blurred_container.dart';
import 'package:fitness_app/features/auth/presentation/login/login_intent.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginForm extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginForm({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: BlurredContainer(
        child: Column(
          children: [
            Text(
              'Login',
              style: AppFontStyle.customAppFont.copyWith(fontSize: 24.sp),
            ).center,
            R.spaceH16,
            TextFormField(
              validator: AppValidators.validateEmail,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: viewModel.emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            R.spaceH16,
            ValueListenableBuilder<bool>(
              valueListenable: viewModel.isPasswordVisible,
              builder: (context, value, child) {
                return TextFormField(
                  controller: viewModel.passwordController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  validator: AppValidators.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
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
              'Forgot Password?',
              style: AppFontStyle.customAppFont.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryOrange,
                decorationThickness: 1.5,
                color: AppColors.primaryOrange,
              ),
            ).align(Alignment.centerRight).onTap(() {
              viewModel.loginIntent(LoginIntent.forgotPasswordButtonPressed);
            }),
            Row(
              children: [
                Divider(
                  color: AppColors.textSecondary,
                  thickness: 1.5,
                  endIndent: 10.w,
                  indent: 20.w,
                ).expanded,
                Text(
                  'OR',
                  style: AppFontStyle.customAppFont.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
                Divider(
                  color: AppColors.textSecondary,
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
                  viewModel.loginIntent(LoginIntent.socialLoginButtonPressed);
                }),
                R.spaceW16,
                Icon(BoxIcons.bxl_google, size: 30.sp).onTap(() {
                  viewModel.loginIntent(LoginIntent.socialLoginButtonPressed);
                }),
                R.spaceW16,
                Icon(BoxIcons.bxl_apple, size: 30.sp).onTap(() {
                  viewModel.loginIntent(LoginIntent.socialLoginButtonPressed);
                }),
              ],
            ),
            R.spaceH16,
            ElevatedButton(
              onPressed: () async {
                viewModel.loginIntent(LoginIntent.loginButtonPressed);
              },
              child: Text(
                'Login',
                style: AppFontStyle.customAppFont.copyWith(fontSize: 18.sp),
              ),
            ),
            R.spaceH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: AppFontStyle.customAppFont.copyWith(fontSize: 14.sp),
                ),
                Text(
                  ' Register',
                  style: AppFontStyle.customAppFont.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.primaryOrange,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryOrange,
                    decorationThickness: 1.5,
                  ),
                ).onTap(() {
                  viewModel.loginIntent(LoginIntent.registerButtonPressed);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
