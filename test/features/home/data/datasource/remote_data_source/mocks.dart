// test/features/home/data/datasource/remote_data_source/mocks.dart
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/repo/home_repository_contract.dart';
import 'package:fitness_app/features/home/domain/usecases/get_food_recommendations.dart';
import 'package:fitness_app/features/home/domain/usecases/get_upcoming_workouts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([HomeRemoteDataSource, HomeRepository])
void main() {}

// Dummy values for Mockito
void setupHomeTestDummies() {
  // Common API results
  provideDummy<ApiResult<Map<String, dynamic>>>(ApiFailure('Dummy failure'));
  provideDummy<ApiResult<dynamic>>(ApiFailure('Dummy failure'));
  provideDummy<Map<String, dynamic>>(<String, dynamic>{});

  // Daily Recommendation response
  provideDummy<DailyRecommendationResponse>(
    DailyRecommendationResponse(
      message: 'Success',
      totalExercises: 0,
      exercises: [],
    ),
  );

  provideDummy<ApiResult<DailyRecommendationResponse>>(
    ApiFailure<DailyRecommendationResponse>('API error'),
  );

  // Upcoming Workouts response
  provideDummy<UpcomingWorkouts>(
    UpcomingWorkouts(message: 'Success', exercises: []),
  );

  provideDummy<ApiResult<UpcomingWorkouts>>(
    ApiFailure<UpcomingWorkouts>('API error'),
  );

  // Food Recommendation response
  provideDummy<FoodRecomendation>(FoodRecomendation(categories: []));

  provideDummy<ApiResult<FoodRecomendation>>(
    ApiFailure<FoodRecomendation>('API error'),
  );

  // Domain Entities (what's primarily used in tests)
  provideDummy<DailyRecommendationItem>(
    DailyRecommendationItem(
      id: 'dummy_id',
      name: 'Dummy Exercise',
      imageUrl: 'https://example.com/dummy.jpg',
    ),
  );

  provideDummy<List<DailyRecommendationItem>>([]);

  provideDummy<ApiResult<List<DailyRecommendationItem>>>(
    ApiFailure<List<DailyRecommendationItem>>('API error'),
  );

  // Future
  provideDummy<Future<void>>(Future.value());
}
