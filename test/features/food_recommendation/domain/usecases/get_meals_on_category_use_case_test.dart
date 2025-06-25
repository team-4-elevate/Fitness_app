import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_on_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/helper/api_result.dart';

import 'get_meals_categories_use_case_test.mocks.dart';

void main() {
  late GetMealsOnCategoryUseCase useCase;
  late MockFoodRecommendRepo mockRepo;

  setUpAll(() {
    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<List<Meal>>>(const ApiFailure('dummy'));
  });

  setUp(() {
    mockRepo = MockFoodRecommendRepo();
    useCase = GetMealsOnCategoryUseCase(mockRepo);
  });

  group('GetMealsOnCategoryUseCase', () {
    group('call', () {
      const testCategory = 'Beef';

      test('should return list of meals when repository succeeds', () async {
        // Arrange
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Beef Stroganoff',
            strMealThumb: 'https://example.com/beef_stroganoff.jpg',
          ),
          Meal(
            idMeal: '2',
            strMeal: 'Beef Wellington',
            strMealThumb: 'https://example.com/beef_wellington.jpg',
          ),
          Meal(
            idMeal: '3',
            strMeal: 'Beef Burger',
            strMealThumb: 'https://example.com/beef_burger.jpg',
          ),
        ];
        const successResult = ApiSuccess<List<Meal>>(mockMeals);

        when(
          mockRepo.getMealsByCategory(testCategory),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.call(testCategory);

        // Assert
        expect(result, isA<ApiSuccess<List<Meal>>>());
        result.when(
          success: (meals) {
            expect(meals, equals(mockMeals));
            expect(meals.length, equals(3));
            expect(meals.first.strMeal, equals('Beef Stroganoff'));
            expect(meals[1].strMeal, equals('Beef Wellington'));
            expect(meals.last.strMeal, equals('Beef Burger'));
          },
          failure: (message) => fail('Should not return failure'),
        );

        verify(mockRepo.getMealsByCategory(testCategory)).called(1);
      });

      test(
        'should return empty list when repository returns empty list',
        () async {
          // Arrange
          const emptyMeals = <Meal>[];
          const successResult = ApiSuccess<List<Meal>>(emptyMeals);

          when(
            mockRepo.getMealsByCategory(testCategory),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await useCase.call(testCategory);

          // Assert
          expect(result, isA<ApiSuccess<List<Meal>>>());
          result.when(
            success: (meals) {
              expect(meals, isEmpty);
              expect(meals.length, equals(0));
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockRepo.getMealsByCategory(testCategory)).called(1);
        },
      );

      test('should return ApiFailure when repository fails', () async {
        // Arrange
        const failureMessage = 'Category not found';
        const failureResult = ApiFailure<List<Meal>>(failureMessage);

        when(
          mockRepo.getMealsByCategory(testCategory),
        ).thenAnswer((_) async => failureResult);

        // Act
        final result = await useCase.call(testCategory);

        // Assert
        expect(result, isA<ApiFailure<List<Meal>>>());
        result.when(
          success: (meals) => fail('Should not return success'),
          failure: (message) {
            expect(message, equals(failureMessage));
          },
        );

        verify(mockRepo.getMealsByCategory(testCategory)).called(1);
      });

      test('should handle different category parameters', () async {
        // Arrange
        const testCategories = ['Beef', 'Chicken', 'Seafood', 'Dessert'];
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Test Meal',
            strMealThumb: 'https://example.com/test_meal.jpg',
          ),
        ];
        const successResult = ApiSuccess<List<Meal>>(mockMeals);

        when(
          mockRepo.getMealsByCategory(any),
        ).thenAnswer((_) async => successResult);

        // Act & Assert
        for (final category in testCategories) {
          final result = await useCase.call(category);

          expect(result, isA<ApiSuccess<List<Meal>>>());
          result.when(
            success: (meals) {
              expect(meals, equals(mockMeals));
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockRepo.getMealsByCategory(category)).called(1);
        }
      });

      test('should handle different error messages from repository', () async {
        // Arrange
        const errorMessages = [
          'Server error 500',
          'No internet connection',
          'Request timeout',
          'Invalid response format',
        ];

        for (final errorMessage in errorMessages) {
          final failureResult = ApiFailure<List<Meal>>(errorMessage);

          when(
            mockRepo.getMealsByCategory(testCategory),
          ).thenAnswer((_) async => failureResult);

          // Act
          final result = await useCase.call(testCategory);

          // Assert
          expect(result, isA<ApiFailure<List<Meal>>>());
          result.when(
            success: (meals) => fail('Should not return success'),
            failure: (message) {
              expect(message, equals(errorMessage));
            },
          );

          verify(mockRepo.getMealsByCategory(testCategory)).called(1);
          reset(mockRepo);
        }
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const exceptionMessage = 'Unexpected error occurred';

        when(
          mockRepo.getMealsByCategory(testCategory),
        ).thenThrow(Exception(exceptionMessage));

        // Act & Assert
        expect(
          () async => await useCase.call(testCategory),
          throwsA(isA<Exception>()),
        );

        verify(mockRepo.getMealsByCategory(testCategory)).called(1);
      });

      test('should call repository method only once per invocation', () async {
        // Arrange
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Beef Steak',
            strMealThumb: 'https://example.com/beef_steak.jpg',
          ),
        ];
        const successResult = ApiSuccess<List<Meal>>(mockMeals);

        when(
          mockRepo.getMealsByCategory(testCategory),
        ).thenAnswer((_) async => successResult);

        // Act
        await useCase.call(testCategory);
        await useCase.call(testCategory);
        await useCase.call(testCategory);

        // Assert
        verify(mockRepo.getMealsByCategory(testCategory)).called(3);
      });

      test('should handle large lists of meals', () async {
        // Arrange
        final largeMealsList = List.generate(
          100,
          (index) => Meal(
            idMeal: '${index + 1}',
            strMeal: 'Meal ${index + 1}',
            strMealThumb: 'https://example.com/meal${index + 1}.jpg',
          ),
        );
        final successResult = ApiSuccess<List<Meal>>(largeMealsList);

        when(
          mockRepo.getMealsByCategory(testCategory),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.call(testCategory);

        // Assert
        expect(result, isA<ApiSuccess<List<Meal>>>());
        result.when(
          success: (meals) {
            expect(meals.length, equals(100));
            expect(meals.first.strMeal, equals('Meal 1'));
            expect(meals.last.strMeal, equals('Meal 100'));
          },
          failure: (message) => fail('Should not return failure'),
        );

        verify(mockRepo.getMealsByCategory(testCategory)).called(1);
      });

      test('should pass correct category parameter to repository', () async {
        // Arrange
        const categories = ['Beef', 'Chicken', 'Seafood'];
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Test Meal',
            strMealThumb: 'https://example.com/test.jpg',
          ),
        ];
        const successResult = ApiSuccess<List<Meal>>(mockMeals);

        when(
          mockRepo.getMealsByCategory(any),
        ).thenAnswer((_) async => successResult);

        // Act
        for (final category in categories) {
          await useCase.call(category);
        }

        // Assert
        for (final category in categories) {
          verify(mockRepo.getMealsByCategory(category)).called(1);
        }
      });
    });

    group('constructor', () {
      test('should create instance with provided repository', () {
        // Act
        final testUseCase = GetMealsOnCategoryUseCase(mockRepo);

        // Assert
        expect(testUseCase, isA<GetMealsOnCategoryUseCase>());
        expect(testUseCase, isNotNull);
      });
    });

    group('integration scenarios', () {
      test(
        'should handle multiple consecutive calls with different categories',
        () async {
          // Arrange
          const beefMeals = [
            Meal(
              idMeal: '1',
              strMeal: 'Beef Steak',
              strMealThumb: 'https://example.com/beef_steak.jpg',
            ),
          ];
          const chickenMeals = [
            Meal(
              idMeal: '2',
              strMeal: 'Chicken Curry',
              strMealThumb: 'https://example.com/chicken_curry.jpg',
            ),
          ];

          when(
            mockRepo.getMealsByCategory('Beef'),
          ).thenAnswer((_) async => const ApiSuccess(beefMeals));
          when(
            mockRepo.getMealsByCategory('Chicken'),
          ).thenAnswer((_) async => const ApiSuccess(chickenMeals));

          // Act
          final result1 = await useCase.call('Beef');
          final result2 = await useCase.call('Chicken');

          // Assert
          expect(result1, isA<ApiSuccess<List<Meal>>>());
          expect(result2, isA<ApiSuccess<List<Meal>>>());

          result1.when(
            success: (meals) {
              expect(meals.first.strMeal, equals('Beef Steak'));
            },
            failure: (message) => fail('First call should succeed'),
          );

          result2.when(
            success: (meals) {
              expect(meals.first.strMeal, equals('Chicken Curry'));
            },
            failure: (message) => fail('Second call should succeed'),
          );

          verify(mockRepo.getMealsByCategory('Beef')).called(1);
          verify(mockRepo.getMealsByCategory('Chicken')).called(1);
        },
      );

      test('should handle same category called multiple times', () async {
        // Arrange
        const mockMeals = [
          Meal(
            idMeal: '1',
            strMeal: 'Beef Steak',
            strMealThumb: 'https://example.com/beef_steak.jpg',
          ),
        ];
        const successResult = ApiSuccess<List<Meal>>(mockMeals);

        when(
          mockRepo.getMealsByCategory('Beef'),
        ).thenAnswer((_) async => successResult);

        // Act
        final result1 = await useCase.call('Beef');
        final result2 = await useCase.call('Beef');
        final result3 = await useCase.call('Beef');

        // Assert
        expect(result1, isA<ApiSuccess<List<Meal>>>());
        expect(result2, isA<ApiSuccess<List<Meal>>>());
        expect(result3, isA<ApiSuccess<List<Meal>>>());

        verify(mockRepo.getMealsByCategory('Beef')).called(3);
      });
    });
  });
}
