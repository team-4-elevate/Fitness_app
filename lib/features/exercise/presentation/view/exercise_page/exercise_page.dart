import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/exercises_list/exercise_list_view.dart';
import 'package:flutter/material.dart';
import '../../../domain/arguments/exercise_page_arguments.dart';
import '../widgets/header/exercise_page_header_view.dart';

class ExercisePage extends StatelessWidget {
  final ExercisePageArguments arguments;
  const ExercisePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.exerciseBottomBg),
            fit: BoxFit.cover)),
        child: Column(
          children: [
            ExercisePageHeaderWidget(arguments: arguments),
            ExerciseListView(muscleGroupId: arguments.muscleGroupId),])));
  }
}
