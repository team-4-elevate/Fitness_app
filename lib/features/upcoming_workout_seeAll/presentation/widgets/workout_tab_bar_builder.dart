// features/upcoming_workout_seeAll/presentation/widgets/workout_tab_bar_builder.dart
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/features/home/presentation/widgets/upcoming-workout_tapbar.dart';
import 'package:fitness_app/features/upcoming_workout_seeAll/presentation/widgets/workout_shimmer_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutTabBarBuilder extends StatelessWidget {
  final HomeStateType state;

  const WorkoutTabBarBuilder({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state is BaseInitialState || state is BaseLoadingState) {
      return const WorkoutShimmerTabBar();
    } else if (state is SuccessState) {
      final successState = state as SuccessState;
      final homeData = successState.data;
      final muscleGroups = homeData.muscleGroups;

      if (muscleGroups.isEmpty) {
        return const SizedBox.shrink();
      }

      final List<String> tabNames = muscleGroups
          .map((group) => group.name ?? 'Category')
          .toList()
          .cast<String>();

      return UpcomingWorkoutTabBar(
        tabNames: tabNames,
        onTabSelected: (index) {
          if (index < muscleGroups.length) {
            final selectedMuscleGroupId = muscleGroups[index].id ?? '';
            context.read<HomeBloc>().add(
                  FetchWorkoutsByMuscleGroupId(
                      muscleGroupId: selectedMuscleGroupId),
                );
          }
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
