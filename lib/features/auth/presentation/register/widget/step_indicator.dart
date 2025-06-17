// features/auth/presentation/register/widget/step_indicator.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalSteps;

    return SizedBox(
      width: 40.r,
      height: 40.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 3.r,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
          ),

          Center(child: Text('$currentStep/$totalSteps')),
        ],
      ),
    );
  }
}
