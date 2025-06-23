// features/home/data/datasource/remote_data_source/home_remote_data_source_impl.dart
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_contract.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ApiResult<DailyRecommendationResponse>> getDailyRecommendations({
    required String targetMuscleGroupId,
    required String difficultyLevelId,
  }) async {
    final queryParams = {
      'targetMuscleGroupId': targetMuscleGroupId,
      'difficultyLevelId': difficultyLevelId,
      'limit': '5', 
    };

    final result = await _apiClient.get<Map<String, dynamic>>(
      '/exercises/random', 
      queryParameters: queryParams,
      requiresToken: true,
    );

    return result.when(
      success: (data) {
        final response = DailyRecommendationResponse.fromJson(data);
        return ApiSuccess(response);
      },
      failure: (failure) => ApiFailure(failure),
    );
  }
}
