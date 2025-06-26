import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/food_details/domain/entities/ingredient_entity.dart';
import 'package:fitness_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:fitness_app/features/food_details/presentation/widgets/ingredient_widget_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngredientListWidget extends StatelessWidget {
  const IngredientListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FoodDetailsCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cubit.state.meal?.ingredients.length ?? 0,
        itemBuilder: (context, index) {
          return IngredientWidgetItem(
            ingredientItem: cubit.state.meal?.ingredients[index] ??
                IngredientEntity(
                  title: 'title',
                  value: 'value',
                ),
          );
        },
      ),
    );
  }
}
