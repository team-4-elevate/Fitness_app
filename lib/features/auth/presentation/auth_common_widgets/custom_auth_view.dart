// features/auth/presentation/auth_common_widgets/custom_auth_view.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../domain/arguments/auth_pages_ui_arguments.dart';
import '../auth_common_widgets/social_buttons.dart';
import '../register/widget/step_indicator.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';

class CustomAuthScreensView extends StatelessWidget {
  final AuthPagesUiArguments args;
  final int? currentStep;
  final int? totalSteps;
  final String? stepTitle;
  final String? stepSubtitle;
  final bool isDetailsStep;
  final VoidCallback? onBackPressed;

  const CustomAuthScreensView({
    super.key,
    required this.args,
    this.currentStep,
    this.totalSteps,
    this.stepTitle,
    this.stepSubtitle,
    this.isDetailsStep = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  // Logo and back button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isDetailsStep) ...[
                        GestureDetector(
                          onTap: onBackPressed,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.r),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 24.r,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                      Center(
                        child: SizedBox(
                          height: 50,
                          width: 70,
                          child: Image.asset('assets/images/fit1.png'),
                        ),
                      ),
                      if (isDetailsStep) const Spacer(),
                    ],
                  ),
                  SizedBox(height: 50.r),

                  // Step indicator when provided
                  if (currentStep != null && totalSteps != null) ...[
                    Center(
                      child: StepIndicator(
                        currentStep: currentStep!,
                        totalSteps: totalSteps!,
                      ),
                    ),
                  ],

                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.firstTitleArguments!.text,
                          style: TextStyle(
                            fontSize:
                                args.firstTitleArguments!.isBold ? 20 : 18,
                            color: Colors.white,
                            fontWeight:
                                args.firstTitleArguments!.isBold
                                    ? FontWeight.w800
                                    : FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 6.r),
                        Text(
                          args.secondTitleArguments!.text,
                          style: TextStyle(
                            fontSize:
                                args.secondTitleArguments!.isBold ? 20 : 18,
                            color: Colors.white,
                            fontWeight:
                                args.secondTitleArguments!.isBold
                                    ? FontWeight.w800
                                    : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main content
                            args.content,

                            // Social login buttons
                            if (args.showSocialLogin) ...[
                              SizedBox(height: 24.r),
                              const SocialButtons(),
                            ],

                            /// Primary action button
                            if (args.primaryButtonText != null) ...[
                              SizedBox(height: 24.r),
                              SizedBox(
                                height: 38.r,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: args.primaryButtonAction,
                                  child: Text(
                                    args.primaryButtonText!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],

                            /// Footer content
                            if (args.footerContent != null) ...[
                              SizedBox(height: 16.r),
                              args.footerContent!,
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
