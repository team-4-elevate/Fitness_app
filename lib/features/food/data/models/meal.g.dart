// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  name: json['strMeal'] as String?,
  imageUrl: json['strMealThumb'] as String?,
  id: json['idMeal'] as String?,
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'strMeal': instance.name,
  'strMealThumb': instance.imageUrl,
  'idMeal': instance.id,
};
