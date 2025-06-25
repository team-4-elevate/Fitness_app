// test/features/home/domain/usecases/get_food_recommendations_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_food_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  late GetFoodRecommendations getFoodRecommendationsUseCase;
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    setupHomeTestDummies();
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getFoodRecommendationsUseCase = GetFoodRecommendations(mockHomeRepository);
  });

  //-------------------------------------------------------success case tests
  group('success cases', () {
    test('should get food recommendations from repository', () async {
      // Arrange
      final mockFoodRecommendations = [
        DailyRecommendationItem(
          id: 'food1',
          name: 'Healthy Salad',
          imageUrl: 'https://example.com/salad.jpg',
        ),
        DailyRecommendationItem(
          id: 'food2',
          name: 'Protein Shake',
          imageUrl: 'https://example.com/shake.jpg',
        ),
      ];

      when(
        mockHomeRepository.getFoodRecommendations(),
      ).thenAnswer((_) async => ApiSuccess(mockFoodRecommendations));

      // Act
      final result = await getFoodRecommendationsUseCase();

      // Assert
      expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());

      result.when(
        success: (data) {
          expect(data.length, equals(2));
          expect(data[0].id, equals('food1'));
          expect(data[0].name, equals('Healthy Salad'));
          expect(data[1].id, equals('food2'));
        },
        failure:
            (message) => fail('Expected success but got failure: $message'),
      );

      // Verify repository call
      verify(mockHomeRepository.getFoodRecommendations()).called(1);
    });
  });

  //-------------------------------------------------------failure case tests
  group('failure cases', () {
    test('should return ApiFailure when repository call fails', () async {
      // Arrange
      const errorMessage = 'Network error';

      when(
        mockHomeRepository.getFoodRecommendations(),
      ).thenAnswer((_) async => ApiFailure(errorMessage));

      // Act
      final result = await getFoodRecommendationsUseCase();

      // Assert
      expect(result, isA<ApiFailure>());

      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (message) {
          expect(message, equals(errorMessage));
        },
      );

      // Verify repository call
      verify(mockHomeRepository.getFoodRecommendations()).called(1);
    });

    test('should handle empty response', () async {
      // Arrange
      final emptyFoodRecommendations = <DailyRecommendationItem>[];

      when(
        mockHomeRepository.getFoodRecommendations(),
      ).thenAnswer((_) async => ApiSuccess(emptyFoodRecommendations));

      // Act
      final result = await getFoodRecommendationsUseCase();

      // Assert
      expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());

      result.when(
        success: (data) {
          expect(data, isEmpty);
        },
        failure:
            (message) => fail('Expected success but got failure: $message'),
      );
    });
  });
}
