// test/features/home/data/datasource/remote_data_source/home_remote_data_source_impl_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/datasource/remote_data_source/home_remote_data_source_impl.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../auth/data/datasource/remote_data_source/mocks.mocks.dart';
import 'mocks.dart';

void main() {
  setUpAll(() {
    setupHomeTestDummies();
  });


//----------------------------------------------------homeRemoteDataSourceImpl Tests
  group('HomeRemoteDataSourceImpl Tests', () {
    late HomeRemoteDataSourceImpl homeRemoteDataSource;
    late MockApiClient mockApiClient;

    setUp(() {
      mockApiClient = MockApiClient();
      homeRemoteDataSource = HomeRemoteDataSourceImpl(mockApiClient);
    });


//----------------------------------------------------getDailyRecommendations Tests
    group('getDailyRecommendations', () {
      const targetMuscleGroupId = 'muscle123';
      const difficultyLevelId = 'level456';

      final mockApiResponse = {
        'message': 'Success',
        'totalExercises': 2,
        'exercises': [
          {
            '_id': 'ex1',
            'exercise': 'Push-ups',
            'body_region': 'Upper body',
            'short_youtube_demonstration_link': 'https://example.com/pushup.mp4',
            'target_muscle_group': 'Chest',
          },
          {
            '_id': 'ex2',
            'exercise': 'Pull-ups',
            'body_region': 'Upper body',
            'short_youtube_demonstration_link': 'https://example.com/pullup.mp4',
            'target_muscle_group': 'Back',
          },
        ],
      };

      test('should return DailyRecommendationResponse on successful API call', () async {
        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockApiResponse));

        final result = await homeRemoteDataSource.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );

        expect(result, isA<ApiSuccess<DailyRecommendationResponse>>());
        
        result.when(
          success: (data) {
            expect(data.message, equals('Success'));
            expect(data.exercises.length, equals(2));
            expect(data.exercises[0].id, equals('ex1'));
            expect(data.exercises[0].exercise, equals('Push-ups'));
            expect(data.exercises[0].bodyRegion, equals('Upper body'));
            expect(data.exercises[1].id, equals('ex2'));
            expect(data.exercises[1].exercise, equals('Pull-ups'));
            expect(data.exercises[1].bodyRegion, equals('Upper body'));
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );

        verify(
          mockApiClient.get(
            '/exercises/random',
            queryParameters: {
              'targetMuscleGroupId': targetMuscleGroupId,
              'difficultyLevelId': difficultyLevelId,
            },
            requiresToken: true,
          ),
        ).called(1);
      });

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Network connection error';
        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));
        final result = await homeRemoteDataSource.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );
        expect(result, isA<ApiFailure<DailyRecommendationResponse>>());
        
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        verify(
          mockApiClient.get(
           '/exercises/random',
            queryParameters: {
              'targetMuscleGroupId': targetMuscleGroupId,
              'difficultyLevelId': difficultyLevelId,
            },
            requiresToken: true,
          ),
        ).called(1);
      });
      
      test('should handle malformed response', () async {
        final malformedResponse = {
          'message': 123, 
          'exercises': null, 
        };

        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(malformedResponse));
        final result = await homeRemoteDataSource.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );
        expect(result, isA<ApiSuccess<DailyRecommendationResponse>>());
        
        result.when(
          success: (data) {
            expect(data.message, isA<String>());
            expect(data.exercises, isNull);
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );
      });
    });

//----------------------------------------------------getUpcomingWorkouts Tests
    group('getUpcomingWorkouts', () {
      final mockApiResponse = {
        'message': 'Success',
        'exercises': [
          {
            '_id': 'ex1',
            'name': 'Morning Cardio',
            'description': 'A quick morning cardio session',
            'imageUrl': 'https://example.com/cardio.jpg',
            'videoUrl': 'https://example.com/cardio.mp4',
            'duration': 20,
            'caloriesBurn': 180,
          },
          {
            '_id': 'ex2',
            'name': 'Evening Yoga',
            'description': 'Relaxing yoga session',
            'imageUrl': 'https://example.com/yoga.jpg',
            'videoUrl': 'https://example.com/yoga.mp4',
            'duration': 30,
            'caloriesBurn': 120,
          },
        ],
      };

      test('should return UpcomingWorkouts on successful API call', () async {
        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockApiResponse));
        final result = await homeRemoteDataSource.getUpcomingWorkouts();
        expect(result, isA<ApiSuccess<UpcomingWorkouts>>());
        
        result.when(
          success: (data) {
            expect(data.message, equals('Success'));
            expect(data.exercises?.length, equals(2));
            expect(data.exercises?[0].id, equals('ex1'));
            expect(data.exercises?[0].exercise, equals('Morning Cardio'));
            expect(data.exercises?[1].id, equals('ex2'));
            expect(data.exercises?[1].mechanics, equals('Evening Yoga'));
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );
        verify(
          mockApiClient.get(
            '/exercises',
            queryParameters: {
              'limit': 5,
            },
            requiresToken: true,
          ),
        ).called(1);
      });

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Network connection error';
        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));
        final result = await homeRemoteDataSource.getUpcomingWorkouts();
        expect(result, isA<ApiFailure<UpcomingWorkouts>>());
        
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );
      });
      
      test('should handle empty response', () async {
                final emptyResponse = {
          'message': 'Success',
          'exercises': [],
        };

        when(
          mockApiClient.get(
            any,
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(emptyResponse));
        final result = await homeRemoteDataSource.getUpcomingWorkouts();

        // Assert
        expect(result, isA<ApiSuccess<UpcomingWorkouts>>());
        
        result.when(
          success: (data) {
            expect(data.message, equals('Success'));
            expect(data.exercises, isEmpty);
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );
      });
    });


//----------------------------------------------------getFoodRecommendations Tests
    group('getFoodRecommendations', () {
      final mockApiResponse = {
        'categories': [
          {
            'idCategory': 'cat1',
            'strCategory': 'Protein',
            'strCategoryThumb': 'https://example.com/protein.jpg',
            'strCategoryDescription': 'High protein foods',
          },
          {
            'idCategory': 'cat2',
            'strCategory': 'Carbs',
            'strCategoryThumb': 'https://example.com/carbs.jpg',
            'strCategoryDescription': 'Complex carbohydrates',
          },
        ],
      };

      test('should return FoodRecomendation on successful API call', () async {
        when(
          mockApiClient.get(
            any,
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockApiResponse));
        final result = await homeRemoteDataSource.getFoodRecommendations();
        expect(result, isA<ApiSuccess<FoodRecomendation>>());
        
        result.when(
          success: (data) {
            expect(data.categories?.length, equals(2));
            expect(data.categories?[0].idCategory, equals('cat1'));
            expect(data.categories?[0].strCategory, equals('Protein'));
            expect(data.categories?[1].idCategory, equals('cat2'));
            expect(data.categories?[1].strCategory, equals('Carbs'));
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );
        verify(
          mockApiClient.get(
                    'https://www.themealdb.com/api/json/v1/1/categories.php',
            requiresToken: false,
          ),
        ).called(1);
      });

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Network connection error';
        when(
          mockApiClient.get(
            any,
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));
        final result = await homeRemoteDataSource.getFoodRecommendations();
        expect(result, isA<ApiFailure<FoodRecomendation>>());
        
        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );
      });
      
      test('should handle empty categories', () async {
        final emptyResponse = {
          'categories': [],
        };

        when(
          mockApiClient.get(
            any,
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(emptyResponse));
        final result = await homeRemoteDataSource.getFoodRecommendations();
        expect(result, isA<ApiSuccess<FoodRecomendation>>());
        
        result.when(
          success: (data) {
            expect(data.categories, isEmpty);
          },
          failure: (message) => fail('Expected success but got failure: $message'),
        );
      });
    });
  });
}
