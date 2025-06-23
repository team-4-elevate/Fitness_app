// features/home/domain/usecases/get_food_recommendations.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFoodRecommendations {
  final HomeRepository repository;

  GetFoodRecommendations(this.repository);

  Future<ApiResult<List<DailyRecommendationItem>>> call() async {
    return await repository.getFoodRecommendations();
  }
}
