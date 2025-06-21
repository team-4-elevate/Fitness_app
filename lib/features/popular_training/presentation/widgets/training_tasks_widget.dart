import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class TrainingTasksWidget extends StatelessWidget {
  const TrainingTasksWidget({super.key, required this.tasksCount});
  final String tasksCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text('$tasksCount tasks', style: context.textTheme.labelLarge),
    );
  }
}
