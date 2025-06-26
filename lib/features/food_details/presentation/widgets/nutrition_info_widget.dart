import 'package:fitness_app/features/food_details/presentation/widgets/nutrition_info_card.dart';
import 'package:flutter/material.dart';

class NutritionInfoWidget extends StatelessWidget {
  const NutritionInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NutritionInfoCard(
          value: '100 K',
          label: 'Energy',
        ),
        Spacer(),
        NutritionInfoCard(
          value: '15 G',
          label: 'Protein',
        ),
        Spacer(),
        NutritionInfoCard(
          value: '58 G',
          label: 'Carbs',
        ),
        Spacer(),
        NutritionInfoCard(
          value: '20 G',
          label: 'Fat',
        ),
      ],
    );
  }
}
