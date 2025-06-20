// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['idCategory'] as String,
  name: json['strCategory'] as String,
  imageUrl: json['strCategoryThumb'] as String?,
  description: json['strCategoryDescription'] as String?,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'idCategory': instance.id,
  'strCategory': instance.name,
  'strCategoryThumb': instance.imageUrl,
  'strCategoryDescription': instance.description,
};
