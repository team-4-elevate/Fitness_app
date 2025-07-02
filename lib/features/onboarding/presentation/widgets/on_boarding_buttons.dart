// features/onboarding/presentation/widgets/on_boarding_buttons.dart
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';

class OnboardingButtons extends StatelessWidget {
  final int index;
  final PageController pageController;

  const OnboardingButtons({
    super.key,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (index) {
      case 0:
        return ElevatedButton(
          key: const Key('first_page_next_button'),
          style: AppTheme.getPrimaryButtonStyle(),
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          child: Text(l10n.next),
        );
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.w,
              child: OutlinedButton(
                key: const Key('second_page_back_button'),
                style: AppTheme.getSecondaryButtonStyle(),
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(l10n.back),
              ),
            ),
            SizedBox(
              width: 100.w,
              child: ElevatedButton(
                key: const Key('second_page_next_button'),
                style: AppTheme.getPrimaryButtonStyle(),
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(l10n.next),
              ),
            ),
          ],
        );
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.w,
              child: OutlinedButton(
                key: const Key('third_page_back_button'),
                style: AppTheme.getSecondaryButtonStyle(),
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(l10n.back),
              ),
            ),
            SizedBox(
              width: 100.w,
              child: ElevatedButton(
                key: const Key('third_page_do_it_button'),
                style: AppTheme.getPrimaryButtonStyle(),
                onPressed: () {
                  context.read<OnboardingBloc>().add(ShowOnboardingCompleted());
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.loginPage);
                },
                child: Text(l10n.doIt),
              ),
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
