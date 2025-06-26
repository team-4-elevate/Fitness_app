// test/features/home/presentation/bloc/home_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/home/data/model/daily_recomendation_exercise/daily_recommendation_response.dart';
import 'package:fitness_app/features/home/domain/entities/daily_recommendation_item.dart';
import 'package:fitness_app/features/home/domain/usecases/get_daily_recommendations_usecase.dart';
import 'package:fitness_app/features/home/domain/usecases/get_food_recommendations.dart';
import 'package:fitness_app/features/home/domain/usecases/get_upcoming_workouts.dart';
import 'package:fitness_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate mocks for the bloc tests
@GenerateMocks([
  GetDailyRecommendationsUseCase,
  // GetUpcomingWorkouts,
  GetFoodRecommendations,
])
import 'home_bloc_test.mocks.dart';

void main() {
  late HomeBloc homeBloc;
  late MockGetDailyRecommendationsUseCase mockGetDailyRecommendations;
  late MockGetUpcomingWorkouts mockGetUpcomingWorkouts;
  late MockGetFoodRecommendations mockGetFoodRecommendations;

  setUp(() {
    mockGetDailyRecommendations = MockGetDailyRecommendationsUseCase();
    mockGetUpcomingWorkouts = MockGetUpcomingWorkouts();
    mockGetFoodRecommendations = MockGetFoodRecommendations();
    homeBloc = HomeBloc(
      mockGetDailyRecommendations,
      // mockGetUpcomingWorkouts,
      mockGetFoodRecommendations,
    );
  });

  tearDown(() {
    homeBloc.close();
  });

  //-------------------------------------------------------initial state tests
  group('Initial State', () {
    test('initial state should be BaseInitialState', () {
      expect(homeBloc.state, isA<BaseInitialState<HomeData>>());
    });
  });

  //-------------------------------------------------------fetch daily recommendations tests
  group('FetchDailyRecommendations Event', () {
    final mockDailyRecommendationResponse = DailyRecommendationResponse(
      message: 'Success',
      totalExercises: 2,
      exercises: [],
    );

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, SuccessState] when daily recommendations are fetched successfully',
      build: () {
        when(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockDailyRecommendationResponse));
        return homeBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDailyRecommendations(
          targetMuscleGroupId: 'muscle123',
          difficultyLevelId: 'level456',
        ),
      ),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<SuccessState<HomeData>>(),
      ],
      verify: (_) {
        verify(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: 'muscle123',
            difficultyLevelId: 'level456',
          ),
        ).called(1);
      },
    );

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, BaseErrorState] when daily recommendations fetch fails',
      build: () {
        when(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => const ApiFailure('Network error'));
        return homeBloc;
      },
      act: (bloc) => bloc.add(
        const FetchDailyRecommendations(
          targetMuscleGroupId: 'muscle123',
          difficultyLevelId: 'level456',
        ),
      ),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<BaseErrorState<HomeData>>().having(
          (state) => state.error,
          'error message',
          'Network error',
        ),
      ],
    );
  });

  //-------------------------------------------------------fetch upcoming workouts tests
  group('FetchUpcomingWorkouts Event', () {
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

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, SuccessState] when upcoming workouts are fetched successfully',
      build: () {
        when(
          mockGetUpcomingWorkouts.call(),
        ).thenAnswer((_) async => ApiSuccess(mockUpcomingWorkouts));
        return homeBloc;
      },
      //act: (bloc) => bloc.add(const FetchUpcomingWorkouts()),
      expect:
          () => [
            isA<BaseLoadingState<HomeData>>(),
            isA<SuccessState<HomeData>>(),
          ],
      verify: (_) {
        verify(mockGetUpcomingWorkouts.call()).called(1);
      },
    );

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, BaseErrorState] when upcoming workouts fetch fails',
      build: () {
        when(
          mockGetUpcomingWorkouts.call(),
        ).thenAnswer((_) async => const ApiFailure('Network error'));
        return homeBloc;
      },
      // act: (bloc) => bloc.add(const FetchUpcomingWorkouts()),
      expect:
          () => [
            isA<BaseLoadingState<HomeData>>(),
            isA<BaseErrorState<HomeData>>().having(
              (state) => state.error,
              'error message',
              'Network error',
            ),
          ],
    );
  });

  //-------------------------------------------------------fetch food recommendations tests
  group('FetchFoodRecommendations Event', () {
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

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, SuccessState] when food recommendations are fetched successfully',
      build: () {
        when(
          mockGetFoodRecommendations.call(),
        ).thenAnswer((_) async => ApiSuccess(mockFoodRecommendations));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const FetchFoodRecommendations()),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<SuccessState<HomeData>>(),
      ],
      verify: (_) {
        verify(mockGetFoodRecommendations.call()).called(1);
      },
    );

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, BaseErrorState] when food recommendations fetch fails',
      build: () {
        when(
          mockGetFoodRecommendations.call(),
        ).thenAnswer((_) async => const ApiFailure('Network error'));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const FetchFoodRecommendations()),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<BaseErrorState<HomeData>>().having(
          (state) => state.error,
          'error message',
          'Network error',
        ),
      ],
    );
  });

  //-------------------------------------------------------load all home data tests
  group('LoadHomeData Event', () {
    final mockDailyRecommendationResponse = DailyRecommendationResponse(
      message: 'Success',
      totalExercises: 2,
      exercises: [],
    );

    final mockUpcomingWorkouts = [
      DailyRecommendationItem(
        id: 'workout1',
        name: 'Morning Yoga',
        imageUrl: 'https://example.com/yoga.jpg',
      ),
    ];

    final mockFoodRecommendations = [
      DailyRecommendationItem(
        id: 'food1',
        name: 'Healthy Snack',
        imageUrl: 'https://example.com/snack.jpg',
      ),
    ];

    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, SuccessState] when fetching all home data successfully',
      build: () {
        when(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockDailyRecommendationResponse));

        when(
          mockGetUpcomingWorkouts.call(),
        ).thenAnswer((_) async => ApiSuccess(mockUpcomingWorkouts));

        when(
          mockGetFoodRecommendations.call(),
        ).thenAnswer((_) async => ApiSuccess(mockFoodRecommendations));

        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<SuccessState<HomeData>>(),
      ],
      verify: (_) {
        verify(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).called(1);
        verify(mockGetUpcomingWorkouts.call()).called(1);
        verify(mockGetFoodRecommendations.call()).called(1);
      },
    );

    // Add a test for failure case
    blocTest<HomeBloc, HomeStateType>(
      'emits [BaseLoadingState, BaseErrorState] when fetching all home data fails',
      build: () {
        when(
          mockGetDailyRecommendations.call(
            targetMuscleGroupId: anyNamed('targetMuscleGroupId'),
            difficultyLevelId: anyNamed('difficultyLevelId'),
          ),
        ).thenAnswer((_) async => const ApiFailure('Network error'));

        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [
        isA<BaseLoadingState<HomeData>>(),
        isA<BaseErrorState<HomeData>>().having(
          (state) => state.error,
          'error message',
          'Network error',
        ),
      ],
    );
  });
}
