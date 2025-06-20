import 'package:json_annotation/json_annotation.dart';
import 'meal.dart';

part 'meals_response.g.dart';

@JsonSerializable()
class MealsResponse {
  final List<Meal> meals;

  MealsResponse({required this.meals});

  factory MealsResponse.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealsResponseToJson(this);
}
