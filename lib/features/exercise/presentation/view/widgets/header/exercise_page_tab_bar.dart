// features/exercise/presentation/view/widgets/header/exercise_page_tab_bar.dart
import 'package:fitness_app/features/exercise/domain/entites/difficulty_level.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_colors.dart';
import 'gradient_blur_header_widget.dart';

class ExerciseTabBar extends StatefulWidget {
  final String muscleGroupId;
  const ExerciseTabBar({super.key, required this.muscleGroupId});

  @override
  State<ExerciseTabBar> createState() => _ExerciseTabBarState();
}

class _ExerciseTabBarState extends State<ExerciseTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  late final List<DifficultyLevelEntity> levels;
  late final ExercisePageBloc bloc;
  @override
  void didChangeDependencies() {
    levels =
        context.read<ExercisePageBloc>().state.levelExerciseMap.keys.toList();
    bloc =
        context.read<ExercisePageBloc>()..add(
          GetExercisesEvent(
            muscleGroupId: widget.muscleGroupId,
            levelId: levels[0].id,
            showLoading: true,
          ),
        );

    controller = TabController(length: levels.length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ExercisePageBlurWidget(
      sigma: 10,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: DefaultTabController(
          length: levels.length,
          child: TabBar(
            physics: const BouncingScrollPhysics(),
            labelStyle: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: AppColors.primaryOrange,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            dividerColor: Colors.transparent,
            onTap:
                (v) => context.read<ExercisePageBloc>().add(
                  GetExercisesEvent(
                    levelId: levels[v].id,
                    muscleGroupId: widget.muscleGroupId,
                    showLoading: true,
                  ),
                ),
            tabs: List.generate(
              levels.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Tab(height: 32, text: levels[index].name),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
