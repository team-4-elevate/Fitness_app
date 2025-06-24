// test/features/home/domain/usecases/get_upcoming_workouts_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_upcoming_workouts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  late GetUpcomingWorkouts getUpcomingWorkoutsUseCase;
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    setupHomeTestDummies();
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getUpcomingWorkoutsUseCase = GetUpcomingWorkouts(mockHomeRepository);
  });

  //-------------------------------------------------------success case tests
  group('success cases', () {
    test('should get upcoming workouts from repository', () async {
      // Arrange
      final mockUpcomingWorkouts = [
        DailyRecommendationItem(
          id: 'workout1',
          name: 'Morning Yoga',
          imageUrl: 'https://example.com/yoga.jpg',
        ),
        DailyRecommendationItem(
          id: 'workout2',
          name: 'Evening Cardio',
          imageUrl: 'https://example.com/cardio.jpg',
        ),
      ];

      when(mockHomeRepository.getUpcomingWorkouts())
          .thenAnswer((_) async => ApiSuccess(mockUpcomingWorkouts));

      // Act
      final result = await getUpcomingWorkoutsUseCase();

      // Assert
      expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());
      
      result.when(
        success: (data) {
          expect(data.length, equals(2));
          expect(data[0].id, equals('workout1'));
          expect(data[0].name, equals('Morning Yoga'));
          expect(data[1].id, equals('workout2'));
        },
        failure: (message) => fail('Expected success but got failure: $message'),
      );

      // Verify repository call
      verify(mockHomeRepository.getUpcomingWorkouts()).called(1);
    });
  });

  //-------------------------------------------------------failure case tests
  group('failure cases', () {
    test('should return ApiFailure when repository call fails', () async {
      // Arrange
      const errorMessage = 'Network error';
      
      when(mockHomeRepository.getUpcomingWorkouts())
          .thenAnswer((_) async => ApiFailure(errorMessage));

      // Act
      final result = await getUpcomingWorkoutsUseCase();

      // Assert
      expect(result, isA<ApiFailure>());
      
      result.when(
        success: (_) => fail('Expected failure but got success'),
        failure: (message) {
          expect(message, equals(errorMessage));
        },
      );

      // Verify repository call
      verify(mockHomeRepository.getUpcomingWorkouts()).called(1);
    });

    test('should handle empty response data', () async {
      // Arrange
      final emptyWorkoutsList = <DailyRecommendationItem>[];
      
      when(mockHomeRepository.getUpcomingWorkouts())
          .thenAnswer((_) async => ApiSuccess(emptyWorkoutsList));

      // Act
      final result = await getUpcomingWorkoutsUseCase();

      // Assert
      expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());
      
      result.when(
        success: (data) {
          expect(data, isEmpty);
        },
        failure: (message) => fail('Expected success but got failure: $message'),
      );

      // Verify repository call
      verify(mockHomeRepository.getUpcomingWorkouts()).called(1);
    });
  });
}
