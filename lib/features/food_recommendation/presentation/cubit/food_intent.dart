import 'package:equatable/equatable.dart';

abstract class FoodIntent extends Equatable {
  const FoodIntent();
}

class GetMealsCategoriesIntent extends FoodIntent {
  const GetMealsCategoriesIntent();

  @override
  List<Object?> get props => [];
}

class GetMealsByCategoryIntent extends FoodIntent {
  final String categoryName;

  const GetMealsByCategoryIntent(this.categoryName);

  @override
  List<Object?> get props => [categoryName];
}

class ChangeSelectedCategoryIntent extends FoodIntent {
  final int index;

  const ChangeSelectedCategoryIntent(this.index);

  @override
  List<Object?> get props => [index];
}
