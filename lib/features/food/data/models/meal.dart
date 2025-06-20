import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal {
  @JsonKey(name: 'strMeal')
  final String? name;

  @JsonKey(name: 'strMealThumb')
  final String? imageUrl;

  @JsonKey(name: 'idMeal')
  final String? id;

  Meal({this.name, this.imageUrl, this.id});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}
