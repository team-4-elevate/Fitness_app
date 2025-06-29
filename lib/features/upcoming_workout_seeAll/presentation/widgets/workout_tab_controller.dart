// features/upcoming_workout_seeAll/presentation/widgets/workout_tab_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:fitness_app/core/base_states/base_state.dart';

class WorkoutTabController {
  late TabController _tabController;
  final TickerProvider vsync;
  final BuildContext context;
  final int? initialSelectedTabIndex;

  WorkoutTabController({
    required this.vsync,
    required this.context,
    this.initialSelectedTabIndex,
  });

  TabController get tabController => _tabController;

  void updateTabController(int tabCount) {
    if (tabCount <= 0) return;

    final previousIndex = _tabController.length > 0 ? _tabController.index : 0;
    _tabController.dispose();

    int initialIndex;
    if (initialSelectedTabIndex != null &&
        initialSelectedTabIndex! < tabCount) {
      initialIndex = initialSelectedTabIndex!;
    } else {
      initialIndex = previousIndex < tabCount ? previousIndex : 0;
    }

    _tabController = TabController(
      length: tabCount,
      vsync: vsync,
      initialIndex: initialIndex,
    );

    _tabController.addListener(_handleTabChange);
    _loadWorkoutsForCurrentTab(initialIndex);
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      final state = context.read<HomeBloc>().state;
      if (state is SuccessState) {
        final successState = state as SuccessState;
        final homeData = successState.data;
        final muscleGroups = homeData.muscleGroups;

        if (muscleGroups.isNotEmpty &&
            _tabController.index < muscleGroups.length) {
          final selectedMuscleGroupId =
              muscleGroups[_tabController.index].id ?? '';
          context.read<HomeBloc>().add(
                FetchWorkoutsByMuscleGroupId(
                  muscleGroupId: selectedMuscleGroupId,
                ),
              );
        }
      }
    }
  }

  void _loadWorkoutsForCurrentTab(int tabIndex) {
    final currentState = context.read<HomeBloc>().state;
    if (currentState is SuccessState) {
      final successState = currentState as SuccessState;
      final homeData = successState.data;
      final muscleGroups = homeData.muscleGroups;

      if (muscleGroups.isNotEmpty && tabIndex < muscleGroups.length) {
        final selectedMuscleGroupId = muscleGroups[tabIndex].id ?? '';
        context.read<HomeBloc>().add(
              FetchWorkoutsByMuscleGroupId(
                muscleGroupId: selectedMuscleGroupId,
              ),
            );
      }
    }
  }

  void initialize() {
    _tabController = TabController(length: 0, vsync: vsync);
  }

  void dispose() {
    _tabController.dispose();
  }

  void refreshCurrentTab() {
    if (_tabController.length > 0) {
      _loadWorkoutsForCurrentTab(_tabController.index);
    }
  }
}
