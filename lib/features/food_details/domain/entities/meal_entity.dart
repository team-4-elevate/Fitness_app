import 'package:fitness_app/features/food_details/domain/entities/ingredient_entity.dart';

class MealEntity {
  final String mealId;
  final String coverUrl;
  final String title;
  final String description;
  final List<IngredientEntity> ingredients;

  MealEntity(
      {required this.mealId,
      required this.coverUrl,
      required this.title,
      required this.description,
      required this.ingredients});
}
