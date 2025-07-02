// features/upcoming_workout_seeAll/presentation/widgets/workout_list_grid.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class WorkoutListGrid extends StatelessWidget {
  final List<dynamic> workouts;
  final Future<void> Function() onRefresh;
  final Widget Function(dynamic workout, int index) buildWorkoutItem;

  const WorkoutListGrid({
    super.key,
    required this.workouts,
    required this.onRefresh,
    required this.buildWorkoutItem,
  });

  @override
  Widget build(BuildContext context) {
    if (workouts.isEmpty) {
      return Center(
        child: Text(
          'No workouts available for this category\nPull down to refresh',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      color: Colors.deepOrange,
      backgroundColor: Colors.black45,
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: workouts.length,
        itemBuilder: (context, index) =>
            buildWorkoutItem(workouts[index], index),
      ),
    );
  }
}
