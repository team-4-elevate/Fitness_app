import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/popular_training/presentation/widgets/training_level_widget.dart';
import 'package:fitness_app/features/popular_training/presentation/widgets/training_tasks_widget.dart';
import 'package:flutter/material.dart';

class TrainingCard extends StatelessWidget {
  const TrainingCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.tasksCount,
    required this.level,
    required this.onTap,
  });
  final String imageUrl;
  final String title;
  final String tasksCount;
  final String level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.r),
              child: Text(
                title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TrainingTasksWidget(tasksCount: tasksCount),
                TrainingLevelWidget(level: level),
              ],
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
