// features/upcoming_workout_seeAll/presentation/widgets/workout_refresh_mixin.dart
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin WorkoutRefreshMixin<T extends StatefulWidget> on State<T> {
  late WorkoutTabController workoutTabController;

  Future<void> refreshWorkouts() async {
    try {
      final homeState = context.read<HomeBloc>().state;
      if (homeState is SuccessState) {
        final successState = homeState as SuccessState;
        final homeData = successState.data;
        final muscleGroups = homeData.muscleGroups;

        if (muscleGroups.isNotEmpty &&
            workoutTabController.tabController.length != muscleGroups.length) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              workoutTabController.updateTabController(muscleGroups.length);
            }
          });
        }

        if (muscleGroups.isNotEmpty &&
            workoutTabController.tabController.index < muscleGroups.length) {
          final selectedMuscleGroupId =
              muscleGroups[workoutTabController.tabController.index].id ?? '';
          context.read<HomeBloc>().add(
                FetchWorkoutsByMuscleGroupId(
                    muscleGroupId: selectedMuscleGroupId),
              );
        }
      }
    } catch (e) {
      print('Error refreshing: $e');
    }

    return await Future.delayed(const Duration(milliseconds: 500));
  }
}
