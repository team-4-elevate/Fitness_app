import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_ViewModel.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_intent.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/widgets/custom_tabbar_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkoutsCategoriesTabbar extends StatelessWidget {
  final TabController tabController;
  final List<MusclesByMuscleGroupIdMusclesDto> IdMuscles;
  final int selectedCategoryIndex;
  const WorkoutsCategoriesTabbar({
    super.key,
    required this.tabController,
    required this.IdMuscles,
    required this.selectedCategoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
          controller: tabController,
          isScrollable: true,
          unselectedLabelColor: AppColors.white,
          dividerColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          indicator: const BoxDecoration(),
          tabAlignment: TabAlignment.start,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: (index) {
            context.read<WorkoutRecommendationViewModel>().doIntent(
              ChangeSelectedGroupIntent(index),
            );
            final categoryName = IdMuscles[index].id ?? '';
            context.read<WorkoutRecommendationViewModel>().doIntent(
              GetMusclesByGroupIntent(categoryName),
            );
          },
          tabs:
              IdMuscles.map((id) {
                return Tab(
                  child: CustomTabbarTab(
                    title: id.name,
                    isSelected:
                        selectedCategoryIndex == IdMuscles.indexOf(id),
                  ),
                );
              }).toList(),
        );
  }
}
