import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_category.g.dart';

@JsonSerializable()
class FoodCategory extends Equatable {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  const FoodCategory({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return _$FoodCategoryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);

  @override
  List<Object?> get props {
    return [idCategory, strCategory, strCategoryThumb, strCategoryDescription];
  }
}
