import 'package:fitness_app/features/exercise/presentation/view/widgets/exercises_list/exercise_widget/youtube_player_widget.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entites/exercise_entity.dart';
import 'exercise_widget_description.dart';
import 'exercise_widget_image.dart';

class ExerciseWidget extends StatelessWidget {
  final ExerciseEntity exercise;

  const ExerciseWidget({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExerciseWidgetImage(link: exercise.youtubeLink),
        ExerciseWidgetDescription(
          name: exercise.name,
          targetMuscleGroup: exercise.targetMuscleGroup,
          primeMoverMuscle: exercise.primeMoverMuscle,
        ),
        ExerciseYoutubePlayerWidget(youtubeLink: exercise.youtubeLink),
      ],
    );
  }
}
