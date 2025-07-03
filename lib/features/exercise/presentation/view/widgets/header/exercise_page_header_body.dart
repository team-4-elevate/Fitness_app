import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../domain/arguments/exercise_page_arguments.dart';
import '../../../bloc/exercise_bloc.dart';
import '../../../bloc/exercise_state.dart';
import 'exercise_page_tab_bar.dart';

class ExercisePageHeaderBody extends StatelessWidget {
  final ExercisePageArguments arguments;
  const ExercisePageHeaderBody({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExercisePageBloc, ExercisePageState>(
      buildWhen: (p, c) {
        return c.getLevelsStatus != p.getLevelsStatus &&
            !c.getLevelsStatus.isInitial;
      },
      builder: (context, state) {
        return state.getLevelsStatus.isSuccess
            ? ExerciseTabBar(muscleGroupId: arguments.muscleGroupId)
            : Skeletonizer(
                enabled: !state.getLevelsStatus.isSuccess,
                child: const SizedBox(height: 50, width: double.infinity),
              );
      },
    );
  }
}
