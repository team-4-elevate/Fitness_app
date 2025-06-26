import 'category.dart';

class FoodRecomendation {
  List<Category>? categories;

  FoodRecomendation({this.categories});

  factory FoodRecomendation.fromJson(Map<String, dynamic> json) {
    return FoodRecomendation(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'categories': categories?.map((e) => e.toJson()).toList(),
      };
}
