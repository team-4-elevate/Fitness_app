// features/home/domain/usecases/get_upcoming_workouts.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUpcomingWorkouts {
  final HomeRepository repository;

  GetUpcomingWorkouts(this.repository);

  Future<ApiResult<List<DailyRecommendationItem>>> call() async {
    return await repository.getUpcomingWorkouts();
  }
}
