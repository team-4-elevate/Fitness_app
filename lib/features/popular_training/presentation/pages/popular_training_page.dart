import 'package:fitness_app/core/generated/assets.dart';
import 'package:fitness_app/features/popular_training/data/models/training_model.dart';
import 'package:fitness_app/features/popular_training/presentation/widgets/popular_training_list_view.dart';
import 'package:flutter/material.dart';

class PopularTrainingPage extends StatelessWidget {
  const PopularTrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TrainingModel> trainingList = [
      TrainingModel(
        id: '1',
        imageUrl: Assets.imagesTrainingImg1,
        title: 'exercises that strengthen your Chest',
        tasksCount: '24',
        level: 'Beginner',
      ),
      TrainingModel(
        id: '2',
        imageUrl: Assets.imagesTrainingImg2,
        title: 'exercises that strengthen your Chest',
        tasksCount: '36',
        level: 'Intermediate',
      ),
      TrainingModel(
        id: '3',
        imageUrl: Assets.imagesTrainingImg3,
        title: 'exercises that strengthen your Chest',
        tasksCount: '48',
        level: 'Advanced',
      ),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Popular Training',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PopularTrainingListView(trainingList: trainingList),
          ],
        ),
      ),
    );
  }
}
