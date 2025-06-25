// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_on_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealsOnCategoryResponse _$MealsOnCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    MealsOnCategoryResponse(
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsOnCategoryResponseToJson(
        MealsOnCategoryResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };
