import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

@JsonSerializable()
class Meal extends Equatable {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  const Meal({this.strMeal, this.strMealThumb, this.idMeal});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

  @override
  List<Object?> get props => [strMeal, strMealThumb, idMeal];
}
