import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/exercise/domain/entites/difficulty_level.dart';
import 'package:fitness_app/features/exercise/domain/entites/exercise_entity.dart';
import 'package:fitness_app/features/exercise/domain/use_cases/get_exercise_use_case.dart';
import 'package:fitness_app/features/exercise/domain/use_cases/get_levels_use_case.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_event.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetLevelsUseCase, GetExercisesUseCase])
import 'exercise_bloc_test.mocks.dart';

void main() {
  late ExercisePageBloc bloc;
  late MockGetLevelsUseCase mockGetLevelsUseCase;
  late MockGetExercisesUseCase mockGetExercisesUseCase;

  setUp(() {
    mockGetLevelsUseCase = MockGetLevelsUseCase();
    mockGetExercisesUseCase = MockGetExercisesUseCase();
    bloc = ExercisePageBloc(
      getLevelsUseCase: mockGetLevelsUseCase,
      getExercisesUseCase: mockGetExercisesUseCase,
    );

    provideDummy<ApiResult<List<DifficultyLevelEntity>>>(
      const ApiSuccess<List<DifficultyLevelEntity>>([]),
    );
    provideDummy<ApiResult<List<ExerciseEntity>>>(
      const ApiSuccess<List<ExerciseEntity>>([]),
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('ExercisePageBloc', () {
    final mockLevels = [
      DifficultyLevelEntity(id: 'level1', name: 'Beginner'),
      DifficultyLevelEntity(id: 'level2', name: 'Intermediate'),
      DifficultyLevelEntity(id: 'level3', name: 'Advanced'),
    ];

    final mockExercises = [
      ExerciseEntity(
        id: 'ex1',
        name: 'Push Up',
        difficulty: 'Beginner',
        youtubeLink: 'https://youtube.com/watch?v=1',
        targetMuscleGroup: 'Chest',
        primeMoverMuscle: 'Pectorals',
      ),
      ExerciseEntity(
        id: 'ex2',
        name: 'Sit Up',
        difficulty: 'Beginner',
        youtubeLink: 'https://youtube.com/watch?v=2',
        targetMuscleGroup: 'Core',
        primeMoverMuscle: 'Abdominals',
      ),
    ];

    test('initial state should be correct', () {
      expect(bloc.state, equals(const ExercisePageState()));
    });

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits [loading, success] states when GetLevelsEvent is added and succeeds',
      build: () {
        when(
          mockGetLevelsUseCase(),
        ).thenAnswer((_) async => ApiSuccess(mockLevels));
        return bloc;
      },
      act: (bloc) => bloc.add(GetLevelsEvent()),
      expect: () => [
        const ExercisePageState(getLevelsStatus: Status.loading),
        ExercisePageState(
          getLevelsStatus: Status.success,
          levelExerciseMap: {
            for (var level in mockLevels) level: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        ),
      ],
      verify: (_) {
        verify(mockGetLevelsUseCase()).called(1);
        verifyNoMoreInteractions(mockGetLevelsUseCase);
        verifyZeroInteractions(mockGetExercisesUseCase);
      },
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits [loading, error] states when GetLevelsEvent is added and fails',
      build: () {
        when(
          mockGetLevelsUseCase(),
        ).thenAnswer((_) async => const ApiFailure('Failed to load levels'));
        return bloc;
      },
      act: (bloc) => bloc.add(GetLevelsEvent()),
      expect: () => [
        const ExercisePageState(getLevelsStatus: Status.loading),
        const ExercisePageState(
          getLevelsStatus: Status.error,
          errorMessage: 'Failed to load levels',
        ),
      ],
      verify: (_) {
        verify(mockGetLevelsUseCase()).called(1);
        verifyNoMoreInteractions(mockGetLevelsUseCase);
        verifyZeroInteractions(mockGetExercisesUseCase);
      },
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when GetExercisesEvent is added and succeeds',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 1),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        levelExerciseMap: {
          for (var level in mockLevels) level: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
      ),
      act: (bloc) => bloc.add(
        const GetExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
          page: 1,
          showLoading: true,
        ),
      ),
      expect: () => [
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.loading,
          levelExerciseMap: {
            for (var level in mockLevels) level: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        ),
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
        ),
      ],
      verify: (_) {
        verify(mockGetExercisesUseCase('muscle1', 'level1', page: 1)).called(1);
        verifyNoMoreInteractions(mockGetExercisesUseCase);
        verifyZeroInteractions(mockGetLevelsUseCase);
      },
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when LoadMoreExercisesEvent is added and succeeds',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 2),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
          mockLevels[2]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        hasMoreExercises: true,
      ),
      act: (bloc) => bloc.add(
        const LoadMoreExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
        ),
      ),
      expect: () => [
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
          isLoadingMore: true,
        ),
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: [...mockExercises, ...mockExercises],
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 2, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
          isLoadingMore: false,
        ),
      ],
      verify: (_) {
        verify(mockGetExercisesUseCase('muscle1', 'level1', page: 2)).called(1);
        verifyNoMoreInteractions(mockGetExercisesUseCase);
        verifyZeroInteractions(mockGetLevelsUseCase);
      },
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when LoadMoreExercisesEvent is added and returns empty list',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 2),
        ).thenAnswer((_) async => const ApiSuccess<List<ExerciseEntity>>([]));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
          mockLevels[2]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        hasMoreExercises: true,
      ),
      act: (bloc) => bloc.add(
        const LoadMoreExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
        ),
      ),
      expect: () => [
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
          isLoadingMore: true,
        ),
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 2, 'level2': 1, 'level3': 1},
          hasMoreExercises: false,
          isLoadingMore: false,
        ),
      ],
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when LoadMoreExercisesEvent fails',
      build: () {
        when(mockGetExercisesUseCase('muscle1', 'level1', page: 2)).thenAnswer(
          (_) async => const ApiFailure('Failed to load more exercises'),
        );
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
          mockLevels[2]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        hasMoreExercises: true,
      ),
      act: (bloc) => bloc.add(
        const LoadMoreExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
        ),
      ),
      expect: () => [
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
          isLoadingMore: true,
        ),
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {
            mockLevels[0]: mockExercises,
            mockLevels[1]: <ExerciseEntity>[],
            mockLevels[2]: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          hasMoreExercises: true,
          isLoadingMore: false,
          errorMessage: 'Failed to load more exercises',
        ),
      ],
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when ShowYoutubeVideoEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ShowYoutubeVideoEvent(
          link: 'https://youtube.com/watch?v=abc123',
        ),
      ),
      expect: () => [
        const ExercisePageState(
          shouldShowYoutubeVideo: true,
          currentVideoLink: 'https://youtube.com/watch?v=abc123',
        ),
      ],
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when CloseYoutubeVideoEvent is added',
      build: () => bloc,
      seed: () => const ExercisePageState(
        currentVideoId: 'abc123',
        shouldShowYoutubeVideo: true,
        currentVideoLink: 'https://youtube.com/watch?v=abc123',
      ),
      act: (bloc) => bloc.add(CloseYoutubeVideoEvent()),
      expect: () => [
        const ExercisePageState(
          currentVideoId: null,
          shouldShowYoutubeVideo: false,
          currentVideoLink: null,
        ),
      ],
    );

    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when GetExercisesEvent is added with existing exercises',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 1),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
          mockLevels[2]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
      ),
      act: (bloc) => bloc.add(
        const GetExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
          page: 1,
          showLoading: false,
        ),
      ),
      expect: () => [],
      verify: (_) {
        verifyZeroInteractions(mockGetExercisesUseCase);
      },
    );

    // New test case 1: Test changing difficulty level
    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when changing level with GetExercisesEvent',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level2', page: 1),
        ).thenAnswer((_) async => ApiSuccess([]));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
          mockLevels[2]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
      ),
      act: (bloc) => bloc.add(
        const GetExercisesEvent(
          levelId: 'level2',
          muscleGroupId: 'muscle1',
          page: 1,
          showLoading: false,
        ),
      ),
      skip: 1,
    );

    // New test case 2: Test GetExercisesEvent with error response
    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when GetExercisesEvent is added and fails',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 1),
        ).thenAnswer((_) async => const ApiFailure('Failed to load exercises'));
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        levelExerciseMap: {
          for (var level in mockLevels) level: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
      ),
      act: (bloc) => bloc.add(
        const GetExercisesEvent(
          levelId: 'level1',
          muscleGroupId: 'muscle1',
          page: 1,
          showLoading: true,
        ),
      ),
      expect: () => [
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.loading,
          levelExerciseMap: {
            for (var level in mockLevels) level: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
        ),
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.error,
          levelExerciseMap: {
            for (var level in mockLevels) level: <ExerciseEntity>[],
          },
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
          errorMessage: 'Failed to load exercises',
        ),
      ],
      verify: (_) {
        verify(mockGetExercisesUseCase('muscle1', 'level1', page: 1)).called(1);
        verifyNoMoreInteractions(mockGetExercisesUseCase);
      },
    );

    // New test case 4: Test consecutive GetExercisesEvent calls for different levels
    blocTest<ExercisePageBloc, ExercisePageState>(
      'emits correct states when GetExercisesEvent is called for different levels',
      build: () {
        when(
          mockGetExercisesUseCase('muscle1', 'level1', page: 1),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));
        when(mockGetExercisesUseCase('muscle1', 'level2', page: 1)).thenAnswer(
          (_) async => ApiSuccess([
            ExerciseEntity(
              id: 'ex3',
              name: 'Bench Press',
              difficulty: 'Intermediate',
              youtubeLink: 'https://youtube.com/watch?v=3',
              targetMuscleGroup: 'Chest',
              primeMoverMuscle: 'Pectorals',
            ),
          ]),
        );
        return bloc;
      },
      seed: () => ExercisePageState(
        getLevelsStatus: Status.success,
        levelExerciseMap: {
          for (var level in mockLevels) level: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1, 'level3': 1},
      ),
      act: (bloc) => {
        bloc.add(
          const GetExercisesEvent(
            levelId: 'level1',
            muscleGroupId: 'muscle1',
            page: 1,
            showLoading: true,
          ),
        ),
        bloc.add(
          const GetExercisesEvent(
            levelId: 'level2',
            muscleGroupId: 'muscle1',
            page: 1,
            showLoading: true,
          ),
        ),
      },
      skip: 5,
      verify: (_) {
        verify(mockGetExercisesUseCase('muscle1', 'level1', page: 1)).called(1);
        verify(mockGetExercisesUseCase('muscle1', 'level2', page: 1)).called(1);
        verifyNoMoreInteractions(mockGetExercisesUseCase);
      },
    );

    // New test case 5: Test handling of YouTube video ID extraction
    blocTest<ExercisePageBloc, ExercisePageState>(
      'correctly extracts video ID from various YouTube URL formats',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ShowYoutubeVideoEvent(
          link: 'https://www.youtube.com/watch?v=abc123&feature=share',
        ),
      ),
      expect: () => [
        const ExercisePageState(
          shouldShowYoutubeVideo: true,
          currentVideoLink:
              'https://www.youtube.com/watch?v=abc123&feature=share',
        ),
      ],
    );
  });
}
