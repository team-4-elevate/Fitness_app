part of 'food_details_cubit.dart';

class FoodDetailsState extends Equatable {
  const FoodDetailsState({
    this.getDetails,
    this.meal,
  });

  final AppStates<MealEntity>? getDetails;
  final MealEntity? meal;

  FoodDetailsState copyWith({
    AppStates<MealEntity>? getDetails,
    MealEntity? meal,
  }) {
    return FoodDetailsState(
      getDetails: getDetails ?? this.getDetails,
      meal: meal ?? this.meal,
    );
  }

  @override
  List<Object?> get props => [
        getDetails,
        meal,
      ];
}
