import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/datasources/food_recommend_remote_data_source.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meals_on_category_response.dart';
import 'package:fitness_app/features/food_recommendation/data/repositories/food_recommend_repo_impl.dart';

import 'food_recommend_repo_impl_test.mocks.dart';

@GenerateMocks([FoodRecommendRemoteDataSource])
void main() {
  late FoodRecommendRepoImpl repository;
  late MockFoodRecommendRemoteDataSource mockDataSource;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<MealsCategoriesResponse>>(const ApiFailure('dummy'));
    provideDummy<ApiResult<MealsOnCategoryResponse>>(const ApiFailure('dummy'));
  });

  setUp(() {
    mockDataSource = MockFoodRecommendRemoteDataSource();
    repository = FoodRecommendRepoImpl(mockDataSource);
  });

  group('FoodRecommendRepoImpl', () {
    group('getMealsCategories', () {
      test(
        'should return list of food categories when data source succeeds',
        () async {
          // Arrange
          const mockCategories = [
            FoodCategory(
              idCategory: '1',
              strCategory: 'Beef',
              strCategoryThumb: 'https://example.com/beef.jpg',
              strCategoryDescription: 'Beef dishes',
            ),
            FoodCategory(
              idCategory: '2',
              strCategory: 'Chicken',
              strCategoryThumb: 'https://example.com/chicken.jpg',
              strCategoryDescription: 'Chicken dishes',
            ),
          ];
          const mockResponse = MealsCategoriesResponse(
            categories: mockCategories,
          );
          const successResult = ApiSuccess(mockResponse);

          when(
            mockDataSource.getMealsCategories(),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await repository.getMealsCategories();

          // Assert
          expect(result, isA<ApiSuccess<List<FoodCategory>>>());
          result.when(
            success: (categories) {
              expect(categories, equals(mockCategories));
              expect(categories.length, equals(2));
              expect(categories.first.strCategory, equals('Beef'));
              expect(categories.last.strCategory, equals('Chicken'));
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockDataSource.getMealsCategories()).called(1);
        },
      );

      test(
        'should return empty list when data source returns null categories',
        () async {
          // Arrange
          const mockResponse = MealsCategoriesResponse(categories: null);
          const successResult = ApiSuccess(mockResponse);

          when(
            mockDataSource.getMealsCategories(),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await repository.getMealsCategories();

          // Assert
          expect(result, isA<ApiSuccess<List<FoodCategory>>>());
          result.when(
            success: (categories) {
              expect(categories, isEmpty);
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockDataSource.getMealsCategories()).called(1);
        },
      );

      test(
        'should return ApiFailure when data source returns failure',
        () async {
          // Arrange
          const failureMessage = 'Network error';
          const failureResult = ApiFailure<MealsCategoriesResponse>(
            failureMessage,
          );

          when(
            mockDataSource.getMealsCategories(),
          ).thenAnswer((_) async => failureResult);

          // Act
          final result = await repository.getMealsCategories();

          // Assert
          expect(result, isA<ApiFailure<List<FoodCategory>>>());
          result.when(
            success: (categories) => fail('Should not return success'),
            failure: (message) {
              expect(message, equals(failureMessage));
            },
          );

          verify(mockDataSource.getMealsCategories()).called(1);
        },
      );

      test(
        'should return ApiFailure when data source throws exception',
        () async {
          // Arrange
          const exceptionMessage = 'Unexpected error';

          when(
            mockDataSource.getMealsCategories(),
          ).thenThrow(Exception(exceptionMessage));

          // Act
          final result = await repository.getMealsCategories();

          // Assert
          expect(result, isA<ApiFailure<List<FoodCategory>>>());
          result.when(
            success: (categories) => fail('Should not return success'),
            failure: (message) {
              expect(message, contains(exceptionMessage));
            },
          );

          verify(mockDataSource.getMealsCategories()).called(1);
        },
      );
    });

    group('getMealsByCategory', () {
      const testCategory = 'Beef';

      test('should return list of meals when data source succeeds', () async {
        // Arrange
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Beef Steak',
            strMealThumb: 'https://example.com/steak.jpg',
          ),
          Meal(
            idMeal: '2',
            strMeal: 'Beef Burger',
            strMealThumb: 'https://example.com/burger.jpg',
          ),
        ];
        const mockResponse = MealsOnCategoryResponse(meals: mockMeals);
        const successResult = ApiSuccess(mockResponse);

        when(
          mockDataSource.getMealsByCategory(testCategory),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await repository.getMealsByCategory(testCategory);

        // Assert
        expect(result, isA<ApiSuccess<List<Meal>>>());
        result.when(
          success: (meals) {
            expect(meals, equals(mockMeals));
            expect(meals.length, equals(2));
            expect(meals.first.strMeal, equals('Beef Steak'));
            expect(meals.last.strMeal, equals('Beef Burger'));
          },
          failure: (message) => fail('Should not return failure'),
        );

        verify(mockDataSource.getMealsByCategory(testCategory)).called(1);
      });

      test(
        'should return empty list when data source returns null meals',
        () async {
          // Arrange
          const mockResponse = MealsOnCategoryResponse(meals: null);
          const successResult = ApiSuccess(mockResponse);

          when(
            mockDataSource.getMealsByCategory(testCategory),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await repository.getMealsByCategory(testCategory);

          // Assert
          expect(result, isA<ApiSuccess<List<Meal>>>());
          result.when(
            success: (meals) {
              expect(meals, isEmpty);
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockDataSource.getMealsByCategory(testCategory)).called(1);
        },
      );

      test(
        'should return ApiFailure when data source returns failure',
        () async {
          // Arrange
          const failureMessage = 'Category not found';
          const failureResult = ApiFailure<MealsOnCategoryResponse>(
            failureMessage,
          );

          when(
            mockDataSource.getMealsByCategory(testCategory),
          ).thenAnswer((_) async => failureResult);

          // Act
          final result = await repository.getMealsByCategory(testCategory);

          // Assert
          expect(result, isA<ApiFailure<List<Meal>>>());
          result.when(
            success: (meals) => fail('Should not return success'),
            failure: (message) {
              expect(message, equals(failureMessage));
            },
          );

          verify(mockDataSource.getMealsByCategory(testCategory)).called(1);
        },
      );

      test(
        'should return ApiFailure when data source throws exception',
        () async {
          // Arrange
          const exceptionMessage = 'Network timeout';

          when(
            mockDataSource.getMealsByCategory(testCategory),
          ).thenThrow(Exception(exceptionMessage));

          // Act
          final result = await repository.getMealsByCategory(testCategory);

          // Assert
          expect(result, isA<ApiFailure<List<Meal>>>());
          result.when(
            success: (meals) => fail('Should not return success'),
            failure: (message) {
              expect(message, contains(exceptionMessage));
            },
          );

          verify(mockDataSource.getMealsByCategory(testCategory)).called(1);
        },
      );

      test('should pass correct category parameter to data source', () async {
        // Arrange
        const testCategories = ['Beef', 'Chicken', 'Seafood'];
        const mockResponse = MealsOnCategoryResponse(meals: []);
        const successResult = ApiSuccess(mockResponse);

        when(
          mockDataSource.getMealsByCategory(any),
        ).thenAnswer((_) async => successResult);

        // Act
        for (final category in testCategories) {
          await repository.getMealsByCategory(category);
        }

        // Assert
        for (final category in testCategories) {
          verify(mockDataSource.getMealsByCategory(category)).called(1);
        }
      });
    });

    group('Error handling', () {
      test(
        'should handle different types of exceptions consistently',
        () async {
          // Arrange
          final exceptions = [
            Exception('Network error'),
            FormatException('Invalid format'),
            ArgumentError('Invalid argument'),
          ];

          for (final exception in exceptions) {
            when(mockDataSource.getMealsCategories()).thenThrow(exception);

            // Act
            final result = await repository.getMealsCategories();

            // Assert
            expect(result, isA<ApiFailure<List<FoodCategory>>>());
            result.when(
              success: (categories) => fail('Should not return success'),
              failure: (message) {
                expect(message, isNotEmpty);
                expect(message, contains(exception.toString()));
              },
            );

            // Reset mock for next iteration
            reset(mockDataSource);
          }
        },
      );
    });
  });
}
