// test/features/home/data/repo/home_repository_impl_test.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/exercise.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/category.dart';
import 'package:fitness_app/features/home/data/model/food_recomendation/food_recomendation/food_recomendation.dart';
import 'package:fitness_app/features/home/data/model/upcoming_workouts/upcoming_workouts/upcoming_workouts.dart';
import 'package:fitness_app/features/home/data/repo/home_repository_impl.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../datasource/remote_data_source/mocks.dart';
import '../datasource/remote_data_source/mocks.mocks.dart';

void main() {
  setUpAll(() {
    setupHomeTestDummies();
  });

  group('HomeRepositoryImpl Tests', () {
    late HomeRepositoryImpl homeRepository;
    late MockHomeRemoteDataSource mockHomeRemoteDataSource;

    setUp(() {
      mockHomeRemoteDataSource = MockHomeRemoteDataSource();
      homeRepository = HomeRepositoryImpl(mockHomeRemoteDataSource);
    });

    //-------------------------------------------------------daily recommendations tests
    group('getDailyRecommendations Tests', () {
      const targetMuscleGroupId = 'muscle123';
      const difficultyLevelId = 'level456';

      final mockExercises = [
        Exercise(
          id: 'ex1',
          exercise: 'Push-ups',
          shortYoutubeDemonstrationLink: 'https://example.com/pushup.mp4',
        ),
        Exercise(
          id: 'ex2',
          exercise: 'Pull-ups',
          shortYoutubeDemonstrationLink: 'https://example.com/pullup.mp4',
        ),
      ];

      final mockDailyRecommendationResponse = DailyRecommendationResponse(
        message: 'Success',
        exercises: mockExercises,
        totalExercises: mockExercises.length,
      );

      test(
        'should return DailyRecommendationResponse on successful API call',
        () async {
          // Arrange
          when(
            mockHomeRemoteDataSource.getDailyRecommendations(
              targetMuscleGroupId: targetMuscleGroupId,
              difficultyLevelId: difficultyLevelId,
            ),
          ).thenAnswer(
            (_) async => ApiSuccess(mockDailyRecommendationResponse),
          );

          // Act
          final result = await homeRepository.getDailyRecommendations(
            targetMuscleGroupId: targetMuscleGroupId,
            difficultyLevelId: difficultyLevelId,
          );

          // Assert
          expect(result, isA<ApiSuccess<DailyRecommendationResponse>>());

          result.when(
            success: (data) {
              expect(
                data.message,
                equals(mockDailyRecommendationResponse.message),
              );
              expect(
                data.exercises.length,
                equals(mockDailyRecommendationResponse.exercises.length),
              );
              expect(
                data.exercises[0].id,
                equals(mockDailyRecommendationResponse.exercises[0].id),
              );
              expect(
                data.exercises[0].exercise,
                equals(mockDailyRecommendationResponse.exercises[0].exercise),
              );
              expect(
                data.exercises[1].id,
                equals(mockDailyRecommendationResponse.exercises[1].id),
              );
            },
            failure: (message) =>
                fail('Expected success but got failure: $message'),
          );

          // Verify method call
          verify(
            mockHomeRemoteDataSource.getDailyRecommendations(
              targetMuscleGroupId: targetMuscleGroupId,
              difficultyLevelId: difficultyLevelId,
            ),
          ).called(1);
        },
      );

      test('should return ApiFailure when remote data source fails', () async {
        // Arrange
        const errorMessage = 'Network connection error';
        when(
          mockHomeRemoteDataSource.getDailyRecommendations(
            targetMuscleGroupId: targetMuscleGroupId,
            difficultyLevelId: difficultyLevelId,
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        // Act
        final result = await homeRepository.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );

        // Assert
        expect(result, isA<ApiFailure<DailyRecommendationResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        // Verify method call
        verify(
          mockHomeRemoteDataSource.getDailyRecommendations(
            targetMuscleGroupId: targetMuscleGroupId,
            difficultyLevelId: difficultyLevelId,
          ),
        ).called(1);
      });

      test('should pass correct parameters to remote data source', () async {
        // Arrange
        when(
          mockHomeRemoteDataSource.getDailyRecommendations(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockDailyRecommendationResponse));

        // Act
        await homeRepository.getDailyRecommendations(
          targetMuscleGroupId: targetMuscleGroupId,
          difficultyLevelId: difficultyLevelId,
        );

        // Assert & Verify
        verify(
          mockHomeRemoteDataSource.getDailyRecommendations(
            targetMuscleGroupId: targetMuscleGroupId,
            difficultyLevelId: difficultyLevelId,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockHomeRemoteDataSource);
      });
    });

    //-------------------------------------------------------upcoming workouts tests
    group('getUpcomingWorkouts Tests', () {
      final mockExercises = [
        Exercise(
          id: 'ex1',
          exercise: 'Push-ups',
          shortYoutubeDemonstrationLink: 'https://example.com/pushup.mp4',
        ),
        Exercise(
          id: 'ex2',
          exercise: 'Pull-ups',
          shortYoutubeDemonstrationLink: 'https://example.com/pullup.mp4',
        ),
      ];

   

   
        });

    //-------------------------------------------------------food recommendations tests
    group('getFoodRecommendations Tests', () {
      final mockCategories = [
        Category(
          idCategory: 'cat1',
          strCategory: 'Protein',
          strCategoryThumb: 'https://example.com/protein.jpg',
          strCategoryDescription: 'High protein foods',
        ),
        Category(
          idCategory: 'cat2',
          strCategory: 'Carbs',
          strCategoryThumb: 'https://example.com/carbs.jpg',
          strCategoryDescription: 'Complex carbohydrates',
        ),
      ];

      final mockFoodRecommendation = FoodRecomendation(
        categories: mockCategories,
      );

      test(
        'should transform FoodRecomendation to List<DailyRecommendationItem> on success',
        () async {
          // Arrange
          when(
            mockHomeRemoteDataSource.getFoodRecommendations(),
          ).thenAnswer((_) async => ApiSuccess(mockFoodRecommendation));

          // Act
          final result = await homeRepository.getFoodRecommendations();

          // Assert
          expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());

          result.when(
            success: (data) {
              expect(data.length, equals(2));
              expect(data[0].id, equals(mockCategories[0].idCategory));
              expect(data[0].name, equals(mockCategories[0].strCategory));
              expect(
                data[0].imageUrl,
                equals(mockCategories[0].strCategoryThumb),
              );
              expect(data[1].id, equals(mockCategories[1].idCategory));
            },
            failure: (message) =>
                fail('Expected success but got failure: $message'),
          );

          // Verify method call
          verify(mockHomeRemoteDataSource.getFoodRecommendations()).called(1);
        },
      );

      test('should return empty list when categories is null', () async {
        // Arrange
        final emptyFoodRecommendation = FoodRecomendation(categories: null);

        when(
          mockHomeRemoteDataSource.getFoodRecommendations(),
        ).thenAnswer((_) async => ApiSuccess(emptyFoodRecommendation));

        // Act
        final result = await homeRepository.getFoodRecommendations();

        // Assert
        expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());

        result.when(
          success: (data) {
            expect(data, isEmpty);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );

        // Verify method call
        verify(mockHomeRemoteDataSource.getFoodRecommendations()).called(1);
      });

      test('should handle empty values in category fields', () async {
        // Arrange
        final categoriesWithNulls = [
          Category(
            idCategory: null,
            strCategory: null,
            strCategoryThumb: null,
            strCategoryDescription: 'Description only',
          ),
        ];

        final foodRecommendationWithNulls = FoodRecomendation(
          categories: categoriesWithNulls,
        );

        when(
          mockHomeRemoteDataSource.getFoodRecommendations(),
        ).thenAnswer((_) async => ApiSuccess(foodRecommendationWithNulls));

        // Act
        final result = await homeRepository.getFoodRecommendations();

        // Assert
        expect(result, isA<ApiSuccess<List<DailyRecommendationItem>>>());

        result.when(
          success: (data) {
            expect(data.length, equals(1));
            expect(data[0].id, equals(''));
            expect(data[0].name, equals(''));
            expect(data[0].imageUrl, equals(''));
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );

        // Verify method call
        verify(mockHomeRemoteDataSource.getFoodRecommendations()).called(1);
      });

      test('should return ApiFailure when remote data source fails', () async {
        // Arrange
        const errorMessage = 'Network connection error';
        when(
          mockHomeRemoteDataSource.getFoodRecommendations(),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        // Act
        final result = await homeRepository.getFoodRecommendations();

        // Assert
        expect(result, isA<ApiFailure<List<DailyRecommendationItem>>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        // Verify method call
        verify(mockHomeRemoteDataSource.getFoodRecommendations()).called(1);
      });
    });
  });
}
