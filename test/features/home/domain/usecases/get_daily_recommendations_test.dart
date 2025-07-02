// test/features/home/domain/usecases/get_daily_recommendations_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/usecases/get_daily_recommendations_usecase.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  late GetDailyRecommendationsUseCase getDailyRecommendationsUseCase;
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    setupHomeTestDummies();
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getDailyRecommendationsUseCase = GetDailyRecommendationsUseCase(
      mockHomeRepository,
    );
  });

  //-------------------------------------------------------success case tests
  group('success cases', () {
    test('should get daily recommendations from repository', () async {
      // Arrange
      const targetMuscleGroupId = 'muscle123';
      const difficultyLevelId = 'level456';
      final mockResponse = DailyRecommendationResponse(
        message: 'Success',
        totalExercises: 2,
        exercises: [],
      );

      when(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
          difficultyLevelId: anyNamed('difficultyLevelId'),
        ),
      ).thenAnswer((_) async => ApiSuccess(mockResponse));

      // Act
      final result = await getDailyRecommendationsUseCase(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
      );

      // Assert
      expect(result, isA<ApiSuccess<DailyRecommendationResponse>>());

      result.when(
        success: (data) {
          expect(data, equals(mockResponse));
          expect(data.message, equals('Success'));
          expect(data.totalExercises, equals(2));
        },
        failure: (message) =>
            fail('Expected success but got failure: $message'),
      );

      // Verify repository was called with correct parameters
      verify(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        ),
      ).called(1);
    });
  });

  //-------------------------------------------------------failure case tests
  group('failure cases', () {
    test('should return ApiFailure when repository call fails', () async {
      // Arrange
      const targetMuscleGroupId = 'muscle123';
      const difficultyLevelId = 'level456';
      const errorMessage = 'Network error';

      when(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
          difficultyLevelId: anyNamed('difficultyLevelId'),
        ),
      ).thenAnswer((_) async => ApiFailure(errorMessage));

      // Act
      final result = await getDailyRecommendationsUseCase(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
      );

      // Assert
      expect(result, isA<ApiFailure>());

      result.when(
        success: (data) => fail('Expected failure but got success'),
        failure: (message) {
          expect(message, equals(errorMessage));
        },
      );

      // Verify repository was called with correct parameters
      verify(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        ),
      ).called(1);
    });

    test('should handle empty or null response data', () async {
      // Arrange
      const targetMuscleGroupId = 'muscle123';
      const difficultyLevelId = 'level456';
      final mockResponse = DailyRecommendationResponse(
        message: 'Success',
        totalExercises: 0,
        exercises: [],
      );

      when(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
          difficultyLevelId: anyNamed('difficultyLevelId'),
        ),
      ).thenAnswer((_) async => ApiSuccess(mockResponse));

      // Act
      final result = await getDailyRecommendationsUseCase(
        targetMuscleGroupId: targetMuscleGroupId,
        difficultyLevelId: difficultyLevelId,
      );

      // Assert
      expect(result, isA<ApiSuccess<DailyRecommendationResponse>>());

      result.when(
        success: (data) {
          expect(data.exercises, isEmpty);
          expect(data.totalExercises, equals(0));
        },
        failure: (message) =>
            fail('Expected success but got failure: $message'),
      );
    });
  });

  //-------------------------------------------------------edge case tests
  group('edge cases', () {
    test('should handle empty parameters', () async {
      // Arrange
      const emptyMuscleGroupId = '';
      const emptyDifficultyLevelId = '';

      when(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: emptyMuscleGroupId,
          difficultyLevelId: emptyDifficultyLevelId,
        ),
      ).thenAnswer((_) async => ApiFailure('Invalid parameters'));

      // Act
      final result = await getDailyRecommendationsUseCase(
        targetMuscleGroupId: emptyMuscleGroupId,
        difficultyLevelId: emptyDifficultyLevelId,
      );

      // Assert
      expect(result, isA<ApiFailure>());

      // Verify repository was called with empty parameters
      verify(
        mockHomeRepository.getDailyRecommendations(
          targetMuscleGroupId: emptyMuscleGroupId,
          difficultyLevelId: emptyDifficultyLevelId,
        ),
      ).called(1);
    });
  });
}
