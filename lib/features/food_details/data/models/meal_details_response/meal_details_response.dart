import 'package:fitness_app/features/food_details/data/models/meal_details_response/meal.dart';

class MealDetailsResponse {
  final List<Meal>? meals;

  const MealDetailsResponse({this.meals});

  factory MealDetailsResponse.fromJson(Map<String, dynamic> json) {
    return MealDetailsResponse(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'meals': meals?.map((e) => e.toJson()).toList(),
      };
}
