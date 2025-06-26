abstract class FoodDetailsIntent {}

class GetFoodDetails extends FoodDetailsIntent {
  final String mealID;

  GetFoodDetails({required this.mealID});
}
