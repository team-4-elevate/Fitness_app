// features/upcoming_workout_seeAll/presentation/widgets/workout_error_view.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class WorkoutErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const WorkoutErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60, color: AppColors.secondaryOrange),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 14),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Try Again', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
