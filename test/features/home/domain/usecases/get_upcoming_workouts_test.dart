// test/features/home/domain/usecases/get_upcoming_workouts_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_upcoming_workouts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  late MockHomeRepository mockHomeRepository;

  setUpAll(() {
    setupHomeTestDummies();
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
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

    });
  });

}
