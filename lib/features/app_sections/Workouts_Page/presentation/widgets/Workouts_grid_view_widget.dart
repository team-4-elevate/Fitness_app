import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/get_all_workout_by_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/workouts_response_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/Workouts_grid_loading.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/grid_view_custom_container.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/grid_view_custom_widget.dart';

import 'package:flutter/material.dart';

class WorkoutGridViewWidget extends StatelessWidget {
  final TabController tabController;
  final List<MuscleGroup> muscleGroups;
  final Map<String, List<MusclesByMuscleGroupIdMusclesDto>> cachedWorkouts;
  final Set<String> loadingGroups;
  final int selectedGroupIndex;

  const WorkoutGridViewWidget({
    super.key,
    required this.tabController,
    required this.muscleGroups,
    required this.cachedWorkouts,
    required this.loadingGroups,
    required this.selectedGroupIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: muscleGroups.asMap().entries.map((entry) {
        final group = entry.value;
        final groupKey = group.name?.toLowerCase() ?? '';
        final workouts = cachedWorkouts[groupKey] ?? [];
        final isLoading = loadingGroups.contains(groupKey);

        if (isLoading) {
          return const WorkoutGridLoading();
        }

        if (workouts.isNotEmpty) {
          return GridViewCustomWidget(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return GridViewCustomContainer(
                imagePath: workout.image ?? '',
                 MusclesName:workout.name?? '',
              );
            },
          );
        }

        return const SizedBox.shrink();
      }).toList(),
    );
  }
}
