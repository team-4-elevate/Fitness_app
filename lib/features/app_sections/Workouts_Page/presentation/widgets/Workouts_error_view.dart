import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/data/models/muscles_by_muscle_group_id_dto.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/cubit/Workouts_ViewModel.dart';
import 'package:flutter/material.dart';

class WorkoutErrorView extends StatelessWidget {
  final String? error;
  final List<MusclesByMuscleGroupIdMusclesDto> categoryList;
  final int selectedCategoryIndex;
  final void Function()? onPressed;
  final WorkoutRecommendationViewModel workoutsViewModel;

  const WorkoutErrorView({
    super.key,
    required this.error,
    required this.categoryList,
    required this.selectedCategoryIndex,
    required this.workoutsViewModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, color: AppColors.red, size: 48.r),
          R.spaceH16,
          Text(
            'فشل في تحميل التمارين',
            style: TextStyle(color: AppColors.white, fontSize: 16.sp),
          ),
          R.spaceH8,
          Text(
            error ?? '',
            style: TextStyle(color: AppColors.white, fontSize: 12.sp),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          R.spaceH16,
          ElevatedButton(
            onPressed: onPressed,
            child: Text(context.l10n.retry),
          ).paddingAll(R.paddingMDValue),
        ],
      ),
    );
  }
}
