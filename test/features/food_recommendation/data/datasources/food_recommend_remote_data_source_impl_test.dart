import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/datasources/food_recommend_remote_data_source_impl.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/meals_categories_response.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meals_on_category_response.dart';

import 'food_recommend_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late FoodRecommendRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUpAll(() {
    // Provide dummy values for all ApiResult types that might be used
    provideDummy<ApiResult<Map<String, dynamic>>>(
      const ApiFailure('dummy map'),
    );
    provideDummy<ApiResult<dynamic>>(const ApiFailure('dummy dynamic'));
    provideDummy<ApiResult<Object?>>(const ApiFailure('dummy object'));
  });

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = FoodRecommendRemoteDataSourceImpl(mockApiClient);
  });

  group('FoodRecommendRemoteDataSourceImpl', () {
    group('getMealsCategories', () {
      test(
        'should call ApiClient.get with correct parameters for categories',
        () async {
          // Arrange
          final mockResponseData = {
            'categories': [
              {
                'idCategory': '1',
                'strCategory': 'Beef',
                'strCategoryThumb': 'https://example.com/beef.jpg',
                'strCategoryDescription': 'Beef dishes',
              },
            ],
          };
          final successResult = ApiSuccess<Map<String, dynamic>>(
            mockResponseData,
          );

          when(
            mockApiClient.get(
              any,
              baseUrl: anyNamed('baseUrl'),
              queryParameters: anyNamed('queryParameters'),
              requiresToken: anyNamed('requiresToken'),
            ),
          ).thenAnswer((_) async => successResult);

          // Act
          await dataSource.getMealsCategories();

          // Assert
          verify(
            mockApiClient.get(
              ApiConstants.foodRecommendedCategoriesEndpoint,
              baseUrl: ApiConstants.foodRecommendBaseUrl,
            ),
          ).called(1);
        },
      );

      test(
        'should return MealsCategoriesResponse when api call succeeds',
        () async {
          // Arrange
          final mockResponseData = {
            'categories': [
              {
                'idCategory': '1',
                'strCategory': 'Beef',
                'strCategoryThumb': 'https://example.com/beef.jpg',
                'strCategoryDescription': 'Beef dishes',
              },
              {
                'idCategory': '2',
                'strCategory': 'Chicken',
                'strCategoryThumb': 'https://example.com/chicken.jpg',
                'strCategoryDescription': 'Chicken dishes',
              },
            ],
          };
          final successResult = ApiSuccess<Map<String, dynamic>>(
            mockResponseData,
          );

          when(
            mockApiClient.get(
              any,
              baseUrl: anyNamed('baseUrl'),
              queryParameters: anyNamed('queryParameters'),
              requiresToken: anyNamed('requiresToken'),
            ),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await dataSource.getMealsCategories();

          // Assert
          expect(result, isA<ApiSuccess<MealsCategoriesResponse>>());
          result.when(
            success: (response) {
              expect(response, isA<MealsCategoriesResponse>());
              expect(response.categories, isNotNull);
              expect(response.categories!.length, equals(2));
              expect(response.categories!.first.strCategory, equals('Beef'));
              expect(response.categories!.last.strCategory, equals('Chicken'));
            },
            failure: (message) => fail('Should not return failure'),
          );
        },
      );

      test('should return ApiFailure when api call fails', () async {
        // Arrange
        const failureMessage = 'Network error';
        const failureResult = ApiFailure<Map<String, dynamic>>(failureMessage);

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => failureResult);

        // Act
        final result = await dataSource.getMealsCategories();

        // Assert
        expect(result, isA<ApiFailure<MealsCategoriesResponse>>());
        result.when(
          success: (response) => fail('Should not return success'),
          failure: (message) {
            expect(message, equals(failureMessage));
          },
        );
      });

      test('should handle json parsing errors gracefully', () async {
        // Arrange
        final invalidResponseData = {'invalid_key': 'invalid_data'};
        final successResult = ApiSuccess<Map<String, dynamic>>(
          invalidResponseData,
        );

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await dataSource.getMealsCategories();

        // Assert
        expect(result, isA<ApiSuccess<MealsCategoriesResponse>>());
        result.when(
          success: (response) {
            expect(response, isA<MealsCategoriesResponse>());
            expect(
              response.categories,
              isNull,
            ); // Categories should be null for invalid data
          },
          failure: (message) => fail('Should not return failure'),
        );
      });
    });

    group('getMealsByCategory', () {
      const testCategory = 'Beef';

      test(
        'should call ApiClient.get with correct parameters for meals by category',
        () async {
          // Arrange
          final mockResponseData = {
            'meals': [
              {
                'idMeal': '1',
                'strMeal': 'Beef Steak',
                'strMealThumb': 'https://example.com/steak.jpg',
              },
            ],
          };
          final successResult = ApiSuccess<Map<String, dynamic>>(
            mockResponseData,
          );

          when(
            mockApiClient.get(
              any,
              baseUrl: anyNamed('baseUrl'),
              queryParameters: anyNamed('queryParameters'),
              requiresToken: anyNamed('requiresToken'),
            ),
          ).thenAnswer((_) async => successResult);

          // Act
          await dataSource.getMealsByCategory(testCategory);

          // Assert
          verify(
            mockApiClient.get(
              ApiConstants.foodRecommendedMealsEndpoint,
              baseUrl: ApiConstants.foodRecommendBaseUrl,
              queryParameters: {'c': testCategory},
            ),
          ).called(1);
        },
      );

      test(
        'should return MealsOnCategoryResponse when api call succeeds',
        () async {
          // Arrange
          final mockResponseData = {
            'meals': [
              {
                'idMeal': '1',
                'strMeal': 'Beef Steak',
                'strMealThumb': 'https://example.com/steak.jpg',
              },
              {
                'idMeal': '2',
                'strMeal': 'Beef Burger',
                'strMealThumb': 'https://example.com/burger.jpg',
              },
            ],
          };
          final successResult = ApiSuccess<Map<String, dynamic>>(
            mockResponseData,
          );

          when(
            mockApiClient.get(
              any,
              baseUrl: anyNamed('baseUrl'),
              queryParameters: anyNamed('queryParameters'),
              requiresToken: anyNamed('requiresToken'),
            ),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await dataSource.getMealsByCategory(testCategory);

          // Assert
          expect(result, isA<ApiSuccess<MealsOnCategoryResponse>>());
          result.when(
            success: (response) {
              expect(response, isA<MealsOnCategoryResponse>());
              expect(response.meals, isNotNull);
              expect(response.meals!.length, equals(2));
              expect(response.meals!.first.strMeal, equals('Beef Steak'));
              expect(response.meals!.last.strMeal, equals('Beef Burger'));
            },
            failure: (message) => fail('Should not return failure'),
          );
        },
      );

      test('should return ApiFailure when api call fails', () async {
        // Arrange
        const failureMessage = 'Category not found';
        const failureResult = ApiFailure<Map<String, dynamic>>(failureMessage);

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => failureResult);

        // Act
        final result = await dataSource.getMealsByCategory(testCategory);

        // Assert
        expect(result, isA<ApiFailure<MealsOnCategoryResponse>>());
        result.when(
          success: (response) => fail('Should not return success'),
          failure: (message) {
            expect(message, equals(failureMessage));
          },
        );
      });

      test('should pass different category parameters correctly', () async {
        // Arrange
        const testCategories = ['Beef', 'Chicken', 'Seafood', 'Dessert'];
        final mockResponseData = {
          'meals': [
            {
              'idMeal': '1',
              'strMeal': 'Test Meal',
              'strMealThumb': 'https://example.com/meal.jpg',
            },
          ],
        };
        final successResult = ApiSuccess<Map<String, dynamic>>(
          mockResponseData,
        );

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => successResult);

        // Act
        for (final category in testCategories) {
          await dataSource.getMealsByCategory(category);
        }

        // Assert
        for (final category in testCategories) {
          verify(
            mockApiClient.get(
              ApiConstants.foodRecommendedMealsEndpoint,
              baseUrl: ApiConstants.foodRecommendBaseUrl,
              queryParameters: {'c': category},
            ),
          ).called(1);
        }
      });

      test('should handle empty meals response', () async {
        // Arrange
        final mockResponseData = {'meals': null};
        final successResult = ApiSuccess<Map<String, dynamic>>(
          mockResponseData,
        );

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await dataSource.getMealsByCategory(testCategory);

        // Assert
        expect(result, isA<ApiSuccess<MealsOnCategoryResponse>>());
        result.when(
          success: (response) {
            expect(response, isA<MealsOnCategoryResponse>());
            expect(response.meals, isNull);
          },
          failure: (message) => fail('Should not return failure'),
        );
      });
    });

    group('Error Handling', () {
      test('should propagate exceptions from ApiClient', () async {
        // Arrange
        const exceptionMessage = 'Network timeout';

        when(
          mockApiClient.get(
            any,
            baseUrl: anyNamed('baseUrl'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenThrow(Exception(exceptionMessage));

        // Act & Assert
        expect(
          () async => await dataSource.getMealsCategories(),
          throwsA(isA<Exception>()),
        );

        expect(
          () async => await dataSource.getMealsByCategory('Beef'),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
