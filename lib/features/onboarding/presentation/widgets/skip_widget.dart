import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/login/presentation/pages/login_page.dart';
import 'package:fitness_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            end: R.paddingMDValue,
            top: R.paddingXLValue,
          ),
          child: TextButton(
            key: const Key('skip_button'),
            onPressed: () {
              context.read<OnboardingBloc>().add(ShowOnboardingCompleted());
              context.pushAndRemoveUntil(const LoginPage());
            },
            child: Text(
              context.l10n.skip,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.darkWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
