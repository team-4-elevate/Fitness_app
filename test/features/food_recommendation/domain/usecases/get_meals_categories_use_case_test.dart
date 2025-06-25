import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/domain/repositories/food_recommend_repo.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_categories_use_case.dart';

import 'get_meals_categories_use_case_test.mocks.dart';

@GenerateMocks([FoodRecommendRepo])
void main() {
  late GetMealsCategoriesUseCase useCase;
  late MockFoodRecommendRepo mockRepo;

  setUpAll(() {
    provideDummy<ApiResult<List<FoodCategory>>>(const ApiFailure('dummy'));
  });

  setUp(() {
    mockRepo = MockFoodRecommendRepo();
    useCase = GetMealsCategoriesUseCase(mockRepo);
  });

  group('GetMealsCategoriesUseCase', () {
    group('call', () {
      test(
        'should return list of food categories when repository succeeds',
        () async {
          // Arrange
          const mockCategories = [
            FoodCategory(
              idCategory: '1',
              strCategory: 'Beef',
              strCategoryThumb: 'https://example.com/beef.jpg',
              strCategoryDescription: 'Beef dishes description',
            ),
            FoodCategory(
              idCategory: '2',
              strCategory: 'Chicken',
              strCategoryThumb: 'https://example.com/chicken.jpg',
              strCategoryDescription: 'Chicken dishes description',
            ),
            FoodCategory(
              idCategory: '3',
              strCategory: 'Seafood',
              strCategoryThumb: 'https://example.com/seafood.jpg',
              strCategoryDescription: 'Seafood dishes description',
            ),
          ];
          const successResult = ApiSuccess<List<FoodCategory>>(mockCategories);

          when(
            mockRepo.getMealsCategories(),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<ApiSuccess<List<FoodCategory>>>());
          result.when(
            success: (categories) {
              expect(categories, equals(mockCategories));
              expect(categories.length, equals(3));
              expect(categories.first.strCategory, equals('Beef'));
              expect(categories[1].strCategory, equals('Chicken'));
              expect(categories.last.strCategory, equals('Seafood'));
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockRepo.getMealsCategories()).called(1);
        },
      );

      test(
        'should return empty list when repository returns empty list',
        () async {
          // Arrange
          const emptyCategories = <FoodCategory>[];
          const successResult = ApiSuccess<List<FoodCategory>>(emptyCategories);

          when(
            mockRepo.getMealsCategories(),
          ).thenAnswer((_) async => successResult);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<ApiSuccess<List<FoodCategory>>>());
          result.when(
            success: (categories) {
              expect(categories, isEmpty);
              expect(categories.length, equals(0));
            },
            failure: (message) => fail('Should not return failure'),
          );

          verify(mockRepo.getMealsCategories()).called(1);
        },
      );

      test('should return ApiFailure when repository fails', () async {
        // Arrange
        const failureMessage = 'Network connection failed';
        const failureResult = ApiFailure<List<FoodCategory>>(failureMessage);

        when(
          mockRepo.getMealsCategories(),
        ).thenAnswer((_) async => failureResult);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<ApiFailure<List<FoodCategory>>>());
        result.when(
          success: (categories) => fail('Should not return success'),
          failure: (message) {
            expect(message, equals(failureMessage));
          },
        );

        verify(mockRepo.getMealsCategories()).called(1);
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
          final failureResult = ApiFailure<List<FoodCategory>>(errorMessage);

          when(
            mockRepo.getMealsCategories(),
          ).thenAnswer((_) async => failureResult);

          // Act
          final result = await useCase.call();

          // Assert
          expect(result, isA<ApiFailure<List<FoodCategory>>>());
          result.when(
            success: (categories) => fail('Should not return success'),
            failure: (message) {
              expect(message, equals(errorMessage));
            },
          );

          verify(mockRepo.getMealsCategories()).called(1);

          // Reset mock for next iteration
          reset(mockRepo);
        }
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const exceptionMessage = 'Unexpected error occurred';

        when(
          mockRepo.getMealsCategories(),
        ).thenThrow(Exception(exceptionMessage));

        // Act & Assert
        expect(() async => await useCase.call(), throwsA(isA<Exception>()));

        verify(mockRepo.getMealsCategories()).called(1);
      });

      test('should call repository method only once per invocation', () async {
        // Arrange
        const mockCategories = [
          FoodCategory(
            idCategory: '1',
            strCategory: 'Beef',
            strCategoryThumb: 'https://example.com/beef.jpg',
            strCategoryDescription: 'Beef dishes',
          ),
        ];
        const successResult = ApiSuccess<List<FoodCategory>>(mockCategories);

        when(
          mockRepo.getMealsCategories(),
        ).thenAnswer((_) async => successResult);

        // Act
        await useCase.call();
        await useCase.call();
        await useCase.call();

        // Assert
        verify(mockRepo.getMealsCategories()).called(3);
      });

      test('should handle large lists of categories', () async {
        // Arrange
        final largeCategoriesList = List.generate(
          100,
          (index) => FoodCategory(
            idCategory: '${index + 1}',
            strCategory: 'Category ${index + 1}',
            strCategoryThumb: 'https://example.com/category${index + 1}.jpg',
            strCategoryDescription: 'Description for category ${index + 1}',
          ),
        );
        final successResult = ApiSuccess<List<FoodCategory>>(
          largeCategoriesList,
        );

        when(
          mockRepo.getMealsCategories(),
        ).thenAnswer((_) async => successResult);

        // Act
        final result = await useCase.call();

        // Assert
        expect(result, isA<ApiSuccess<List<FoodCategory>>>());
        result.when(
          success: (categories) {
            expect(categories.length, equals(100));
            expect(categories.first.strCategory, equals('Category 1'));
            expect(categories.last.strCategory, equals('Category 100'));
          },
          failure: (message) => fail('Should not return failure'),
        );

        verify(mockRepo.getMealsCategories()).called(1);
      });
    });

    group('constructor', () {
      test('should create instance with provided repository', () {
        // Act
        final testUseCase = GetMealsCategoriesUseCase(mockRepo);

        // Assert
        expect(testUseCase, isA<GetMealsCategoriesUseCase>());
        expect(testUseCase, isNotNull);
      });
    });

    group('integration scenarios', () {
      test('should handle multiple consecutive calls correctly', () async {
        // Arrange
        const categories1 = [
          FoodCategory(
            idCategory: '1',
            strCategory: 'Beef',
            strCategoryThumb: 'https://example.com/beef.jpg',
            strCategoryDescription: 'Beef dishes',
          ),
        ];
        const categories2 = [
          FoodCategory(
            idCategory: '2',
            strCategory: 'Chicken',
            strCategoryThumb: 'https://example.com/chicken.jpg',
            strCategoryDescription: 'Chicken dishes',
          ),
        ];

        // Use counter for consecutive calls
        int callCount = 0;
        when(mockRepo.getMealsCategories()).thenAnswer((_) async {
          if (callCount == 0) {
            callCount++;
            return const ApiSuccess(categories1);
          } else {
            return const ApiSuccess(categories2);
          }
        });

        // Act
        final result1 = await useCase.call();
        final result2 = await useCase.call();

        // Assert
        expect(result1, isA<ApiSuccess<List<FoodCategory>>>());
        expect(result2, isA<ApiSuccess<List<FoodCategory>>>());

        result1.when(
          success: (categories) {
            expect(categories.first.strCategory, equals('Beef'));
          },
          failure: (message) => fail('First call should succeed'),
        );

        result2.when(
          success: (categories) {
            expect(categories.first.strCategory, equals('Chicken'));
          },
          failure: (message) => fail('Second call should succeed'),
        );

        verify(mockRepo.getMealsCategories()).called(2);
      });
    });
  });
}
