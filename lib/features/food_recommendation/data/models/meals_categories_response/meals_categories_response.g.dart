// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealsCategoriesResponse _$MealsCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    MealsCategoriesResponse(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => FoodCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealsCategoriesResponseToJson(
        MealsCategoriesResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
