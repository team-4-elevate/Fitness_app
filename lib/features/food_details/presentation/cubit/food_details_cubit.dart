import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/food_details/domain/entities/meal_entity.dart';
import 'package:fitness_app/features/food_details/domain/usecases/get_food_details_use_case.dart';
import 'package:fitness_app/features/food_details/presentation/cubit/food_details_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'food_details_state.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final GetFoodDetailsUseCase getFoodDetailsUseCase;
  FoodDetailsCubit(
    this.getFoodDetailsUseCase,
  ) : super(const FoodDetailsState());

  void foodDetailsIntent(FoodDetailsIntent foodDetailsIntent) {
    switch (foodDetailsIntent) {
      case GetFoodDetails(mealID: final mealID):
        _getFoodDetails(mealID);
        break;
      default:
    }
  }

  Future<void> _getFoodDetails(String mealID) async {
    emit(state.copyWith(getDetails: const LoadingState()));
    var result = await getFoodDetailsUseCase.call(mealID);
    result.when(
      success: (data) {
        emit(
          state.copyWith(
            getDetails: SuccessState(),
            meal: data,
          ),
        );
      },
      failure: (message) {
        emit(state.copyWith(getDetails: ErrorState(message)));
      },
    );
  }
}
