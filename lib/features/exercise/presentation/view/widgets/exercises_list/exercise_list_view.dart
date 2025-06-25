// features/exercise/presentation/view/widgets/exercises_list/exercise_list_view.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/exercises_list/exercises_pagination_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/app_manger/bloc_handler_mixin.dart';
import '../../../bloc/exercise_bloc.dart';
import '../../../bloc/exercise_state.dart';
import 'exercises_list_shimmer.dart';

class ExerciseListView extends StatelessWidget {
  final String muscleGroupId;
  const ExerciseListView({super.key, required this.muscleGroupId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisePageBloc, ExercisePageState>(
      buildWhen: (p, c) {
        return p.getExercisesStatus != c.getExercisesStatus;
      },
      builder: (context, state) {
        if (state.getExercisesStatus.isError) {
          return Center(
            child: Text(
              state.errorMessage ?? context.l10n.unknownError,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        if (state.levelExerciseMap.isNotEmpty &&
            state.getExercisesStatus.isSuccess) {
          final stateExercises =
              state.levelExerciseMap[state.levelExerciseMap.keys.firstWhere(
                (k) => k.id == state.currentLevelId,
              )];
          return Expanded(
            child:
                stateExercises == null || stateExercises.isEmpty
                    ? Text(
                      context.l10n.no_exercises_found,
                      textAlign: TextAlign.center,
                    )
                    : ExercisesPaginationView(
                      stateExercises: stateExercises,
                      levelId: state.currentLevelId!,
                      muscleGroupId: muscleGroupId,
                    ),
          );
        }
        return Expanded(child: DummyExercisesListShimmer());
      },
    );
  }
}
