import 'package:fitness_app/features/exercise/domain/entites/exercise_entity.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/exercises_list/exercise_widget/exercise_widget.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DummyExercisesListShimmer extends StatelessWidget {
  const DummyExercisesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Opacity(
        opacity: 0.55,
        child: Skeletonizer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 16),
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ExerciseWidget(
                  exercise: ExerciseEntity(
                    id: 'id',
                    name: 'name',
                    difficulty: 'difficulty',
                    youtubeLink: 'youtubeLink',
                    targetMuscleGroup: 'targetMuscleGroup',
                    primeMoverMuscle: 'primeMoverMuscle',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
