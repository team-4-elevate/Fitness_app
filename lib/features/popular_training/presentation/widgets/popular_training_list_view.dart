import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/popular_training/data/models/training_model.dart';
import 'package:fitness_app/features/popular_training/presentation/widgets/training_card.dart';
import 'package:flutter/material.dart';

class PopularTrainingListView extends StatelessWidget {
  const PopularTrainingListView({super.key, required this.trainingList});
  final List<TrainingModel> trainingList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0.h,
      width: double.infinity,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),

        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 16.0.w),
        itemCount: trainingList.length,

        itemBuilder:
            (context, index) => TrainingCard(
              key: Key('training_card_$index'),
              imageUrl: trainingList[index].imageUrl,
              title: trainingList[index].title,
              tasksCount: trainingList[index].tasksCount,
              level: trainingList[index].level,
              onTap: () {
                // Handle tap action
                print(
                  'Tapped on training card with ID ${trainingList[index].id}\nTitle: ${trainingList[index].title}',
                );
              },
            ),
      ),
    );
  }
}
