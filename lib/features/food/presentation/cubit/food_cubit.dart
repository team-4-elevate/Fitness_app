import 'package:fitness_app/features/food/data/models/meal.dart';
import 'package:fitness_app/features/food/domain/usecase/get_meals_use_case.dart';
import 'package:fitness_app/features/food/presentation/cubit/food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FoodCubit extends Cubit<FoodState> {
  final GetMealsUseCase _getMealsUseCase;
  FoodCubit(this._getMealsUseCase) : super(FoodState.initial());

  List<Meal> realMeals = [];

  Future<void> fetchMeals(String category) async {
    emit(FoodState.loading());
    final response = await _getMealsUseCase.execute(category);
    response.when(
      success: (mealsResponse) {
        emit(FoodState.success(mealsResponse.meals));
        realMeals.clear();
        realMeals.addAll(mealsResponse.meals);
      },
      failure: (error) {
        emit(FoodState.error(message: error));
      },
    );
  }
}
