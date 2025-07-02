import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meal.dart';

part 'meals_on_category_response.g.dart';

@JsonSerializable()
class MealsOnCategoryResponse extends Equatable {
  final List<Meal>? meals;

  const MealsOnCategoryResponse({this.meals});

  factory MealsOnCategoryResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsOnCategoryResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MealsOnCategoryResponseToJson(this);

  @override
  List<Object?> get props => [meals];
}
