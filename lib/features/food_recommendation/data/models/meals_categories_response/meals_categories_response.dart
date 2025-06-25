import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'food_category.dart';

part 'meals_categories_response.g.dart';

@JsonSerializable()
class MealsCategoriesResponse extends Equatable {
  final List<FoodCategory>? categories;

  const MealsCategoriesResponse({this.categories});

  factory MealsCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$MealsCategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MealsCategoriesResponseToJson(this);

  @override
  List<Object?> get props => [categories];
}
