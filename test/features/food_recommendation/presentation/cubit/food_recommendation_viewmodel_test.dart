import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_on_category_response/meal.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_categories_use_case.dart';
import 'package:fitness_app/features/food_recommendation/domain/usecases/get_meals_on_category_use_case.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';

import 'food_recommendation_viewmodel_test.mocks.dart';

@GenerateMocks([GetMealsCategoriesUseCase, GetMealsOnCategoryUseCase])
void main() {
  late FoodRecommendationViewModel viewModel;
  late MockGetMealsCategoriesUseCase mockMealsCategoriesUseCase;
  late MockGetMealsOnCategoryUseCase mockMealsOnCategoryUseCase;

  setUpAll(() {
    provideDummy<ApiResult<List<FoodCategory>>>(
      const ApiFailure('dummy categories'),
    );
    provideDummy<ApiResult<List<Meal>>>(const ApiFailure('dummy meals'));
  });

  setUp(() {
    mockMealsCategoriesUseCase = MockGetMealsCategoriesUseCase();
    mockMealsOnCategoryUseCase = MockGetMealsOnCategoryUseCase();
    viewModel = FoodRecommendationViewModel(
      mockMealsCategoriesUseCase,
      mockMealsOnCategoryUseCase,
    );
  });

  group('FoodRecommendationViewModel', () {
    group('initial state', () {
      test('should have correct initial state', () {
        expect(viewModel.state, equals(const FoodRecommendationState()));
        expect(viewModel.state.foodCategoriesState, isNull);
        expect(viewModel.state.mealsByCategoryState, isNull);
        expect(viewModel.state.selectedCategoryIndex, equals(0));
        expect(viewModel.state.cachedMeals, isEmpty);
        expect(viewModel.state.loadingCategories, isEmpty);
        expect(viewModel.state.categories, isEmpty);
      });
    });

    group('GetMealsCategoriesIntent', () {
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

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should emit loading then success when categories are fetched successfully',
        build: () {
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiSuccess(mockCategories));
          return viewModel;
        },
        act: (cubit) => cubit.doIntent(const GetMealsCategoriesIntent()),
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: LoadingState(),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
              ),
            ],
        verify: (_) {
          verify(mockMealsCategoriesUseCase.call()).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should emit loading then error when categories fetch fails',
        build: () {
          const errorMessage = 'Network error';
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiFailure(errorMessage));
          return viewModel;
        },
        act: (cubit) => cubit.doIntent(const GetMealsCategoriesIntent()),
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: LoadingState(),
              ),
              const FoodRecommendationState(
                foodCategoriesState: ErrorState('Network error'),
              ),
            ],
        verify: (_) {
          verify(mockMealsCategoriesUseCase.call()).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should emit loading then success with empty list',
        build: () {
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiSuccess(<FoodCategory>[]));
          return viewModel;
        },
        act: (cubit) => cubit.doIntent(const GetMealsCategoriesIntent()),
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: LoadingState(),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(<FoodCategory>[]),
              ),
            ],
        verify: (_) {
          verify(mockMealsCategoriesUseCase.call()).called(1);
        },
      );
    });

    group('GetMealsByCategoryIntent', () {
      const testCategory = 'Beef';
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
      ];

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should emit loading state then success when meals are fetched successfully',
        build: () {
          when(
            mockMealsOnCategoryUseCase.call(testCategory),
          ).thenAnswer((_) async => const ApiSuccess(mockMeals));
          return viewModel;
        },
        act:
            (cubit) =>
                cubit.doIntent(const GetMealsByCategoryIntent(testCategory)),
        expect:
            () => [
              const FoodRecommendationState(loadingCategories: {'beef'}),
              FoodRecommendationState(
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
              ),
            ],
        verify: (_) {
          verify(mockMealsOnCategoryUseCase.call(testCategory)).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should emit loading state then error when meals fetch fails',
        build: () {
          const errorMessage = 'Category not found';
          when(
            mockMealsOnCategoryUseCase.call(testCategory),
          ).thenAnswer((_) async => const ApiFailure(errorMessage));
          return viewModel;
        },
        act:
            (cubit) =>
                cubit.doIntent(const GetMealsByCategoryIntent(testCategory)),
        expect:
            () => [
              const FoodRecommendationState(loadingCategories: {'beef'}),
              const FoodRecommendationState(
                mealsByCategoryState: ErrorState('Category not found'),
                loadingCategories: <String>{},
              ),
            ],
        verify: (_) {
          verify(mockMealsOnCategoryUseCase.call(testCategory)).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should not call use case when meals are already cached',
        build: () => viewModel,
        seed:
            () =>
                const FoodRecommendationState(cachedMeals: {'beef': mockMeals}),
        act:
            (cubit) =>
                cubit.doIntent(const GetMealsByCategoryIntent(testCategory)),
        expect: () => <FoodRecommendationState>[],
        verify: (_) {
          verifyNever(mockMealsOnCategoryUseCase.call(any));
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should handle empty meals response',
        build: () {
          when(
            mockMealsOnCategoryUseCase.call(testCategory),
          ).thenAnswer((_) async => const ApiSuccess(<Meal>[]));
          return viewModel;
        },
        act:
            (cubit) =>
                cubit.doIntent(const GetMealsByCategoryIntent(testCategory)),
        expect:
            () => [
              const FoodRecommendationState(loadingCategories: {'beef'}),
              const FoodRecommendationState(
                mealsByCategoryState: SuccessState(<Meal>[]),
                cachedMeals: {'beef': <Meal>[]},
                loadingCategories: <String>{},
              ),
            ],
        verify: (_) {
          verify(mockMealsOnCategoryUseCase.call(testCategory)).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should handle exception and emit error state',
        build: () {
          when(
            mockMealsOnCategoryUseCase.call(testCategory),
          ).thenThrow(Exception('Network timeout'));
          return viewModel;
        },
        act:
            (cubit) =>
                cubit.doIntent(const GetMealsByCategoryIntent(testCategory)),
        expect:
            () => [
              const FoodRecommendationState(loadingCategories: {'beef'}),
              const FoodRecommendationState(
                mealsByCategoryState: ErrorState('Exception: Network timeout'),
                loadingCategories: <String>{},
              ),
            ],
        verify: (_) {
          verify(mockMealsOnCategoryUseCase.call(testCategory)).called(1);
        },
      );
    });

    group('ChangeSelectedCategoryIntent', () {
      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should update selected category index',
        build: () => viewModel,
        act: (cubit) => cubit.doIntent(const ChangeSelectedCategoryIntent(2)),
        expect: () => [const FoodRecommendationState(selectedCategoryIndex: 2)],
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should handle multiple category index changes',
        build: () => viewModel,
        act: (cubit) {
          cubit.doIntent(const ChangeSelectedCategoryIntent(1));
          cubit.doIntent(const ChangeSelectedCategoryIntent(3));
          cubit.doIntent(const ChangeSelectedCategoryIntent(0));
        },
        expect:
            () => [
              const FoodRecommendationState(selectedCategoryIndex: 1),
              const FoodRecommendationState(selectedCategoryIndex: 3),
              const FoodRecommendationState(selectedCategoryIndex: 0),
            ],
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should preserve other state when changing category index',
        build: () => viewModel,
        seed:
            () => const FoodRecommendationState(
              foodCategoriesState: SuccessState([]),
              cachedMeals: {'beef': []},
              loadingCategories: {'chicken'},
            ),
        act: (cubit) => cubit.doIntent(const ChangeSelectedCategoryIntent(5)),
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: SuccessState([]),
                cachedMeals: {'beef': []},
                loadingCategories: {'chicken'},
                selectedCategoryIndex: 5,
              ),
            ],
      );
    });

    group('Sequential operations', () {
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

      const mockMeals = [
        Meal(
          idMeal: '1',
          strMeal: 'Beef Stroganoff',
          strMealThumb: 'https://example.com/beef_stroganoff.jpg',
        ),
      ];

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should handle categories fetch then meals fetch sequentially',
        build: () {
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiSuccess(mockCategories));
          when(
            mockMealsOnCategoryUseCase.call('Beef'),
          ).thenAnswer((_) async => const ApiSuccess(mockMeals));
          return viewModel;
        },
        act: (cubit) async {
          cubit.doIntent(const GetMealsCategoriesIntent());
          await Future.delayed(const Duration(milliseconds: 10));
          cubit.doIntent(const GetMealsByCategoryIntent('Beef'));
        },
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: LoadingState(),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
                loadingCategories: {'beef'},
              ),
              FoodRecommendationState(
                foodCategoriesState: const SuccessState(mockCategories),
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
              ),
            ],
        verify: (_) {
          verify(mockMealsCategoriesUseCase.call()).called(1);
          verify(mockMealsOnCategoryUseCase.call('Beef')).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should handle mixed successful and failed operations sequentially',
        build: () {
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiSuccess(mockCategories));
          when(
            mockMealsOnCategoryUseCase.call('Beef'),
          ).thenAnswer((_) async => const ApiFailure('Network error'));
          return viewModel;
        },
        act: (cubit) async {
          cubit.doIntent(const GetMealsCategoriesIntent());
          await Future.delayed(const Duration(milliseconds: 10));
          cubit.doIntent(const GetMealsByCategoryIntent('Beef'));
          await Future.delayed(const Duration(milliseconds: 10));
          cubit.doIntent(const ChangeSelectedCategoryIntent(1));
        },
        expect:
            () => [
              const FoodRecommendationState(
                foodCategoriesState: LoadingState(),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
                loadingCategories: {'beef'},
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
                mealsByCategoryState: ErrorState('Network error'),
                loadingCategories: <String>{},
              ),
              const FoodRecommendationState(
                foodCategoriesState: SuccessState(mockCategories),
                mealsByCategoryState: ErrorState('Network error'),
                loadingCategories: <String>{},
                selectedCategoryIndex: 1,
              ),
            ],
        verify: (_) {
          verify(mockMealsCategoriesUseCase.call()).called(1);
          verify(mockMealsOnCategoryUseCase.call('Beef')).called(1);
        },
      );

      blocTest<FoodRecommendationViewModel, FoodRecommendationState>(
        'should maintain cache across different operations sequentially',
        build: () {
          when(
            mockMealsOnCategoryUseCase.call('Beef'),
          ).thenAnswer((_) async => const ApiSuccess(mockMeals));
          when(
            mockMealsCategoriesUseCase.call(),
          ).thenAnswer((_) async => const ApiSuccess(mockCategories));
          return viewModel;
        },
        act: (cubit) async {
          cubit.doIntent(const GetMealsByCategoryIntent('Beef'));
          await Future.delayed(const Duration(milliseconds: 10));
          cubit.doIntent(const GetMealsCategoriesIntent());
          await Future.delayed(const Duration(milliseconds: 10));
          cubit.doIntent(const ChangeSelectedCategoryIntent(2));
        },
        expect:
            () => [
              const FoodRecommendationState(loadingCategories: {'beef'}),
              FoodRecommendationState(
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
              ),
              FoodRecommendationState(
                foodCategoriesState: const LoadingState(),
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
              ),
              FoodRecommendationState(
                foodCategoriesState: const SuccessState(mockCategories),
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
              ),
              FoodRecommendationState(
                foodCategoriesState: const SuccessState(mockCategories),
                mealsByCategoryState: const SuccessState(mockMeals),
                cachedMeals: const {'beef': mockMeals},
                loadingCategories: const <String>{},
                selectedCategoryIndex: 2,
              ),
            ],
        verify: (_) {
          verify(mockMealsOnCategoryUseCase.call('Beef')).called(1);
          verify(mockMealsCategoriesUseCase.call()).called(1);
        },
      );
    });

    group('close', () {
      tearDown(() {
        viewModel.close();
      });
    });
  });
}
