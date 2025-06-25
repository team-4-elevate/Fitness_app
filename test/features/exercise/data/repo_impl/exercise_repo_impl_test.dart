import 'package:fitness_app/features/exercise/data/data_sources/remote/exercise_remote_ds_interface.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/model/difficulty_level_dm.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';
import 'package:fitness_app/features/exercise/data/repo_impl/exercise_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/helper/api_result.dart';

import 'exercise_repo_impl_test.mocks.dart';

@GenerateMocks([ExerciseRemoteDsInterface])
void main() {
  late ExerciseRepoImpl exerciseRepo;
  late MockExerciseRemoteDsInterface mockExerciseRemoteDs;

  setUp(() {
    mockExerciseRemoteDs = MockExerciseRemoteDsInterface();
    exerciseRepo = ExerciseRepoImpl(mockExerciseRemoteDs);

    provideDummy<ApiResult<List<ExerciseDM>>>(
      const ApiSuccess<List<ExerciseDM>>([]),
    );
    provideDummy<ApiResult<List<DifficultyLevelDM>>>(
      const ApiSuccess<List<DifficultyLevelDM>>([]),
    );
  });

  group('ExerciseRepoImpl', () {
    group('fetchExercises', () {
      const levelId = 'level1';
      const muscleGroupId = 'muscle1';
      const page = 1;

      final mockExercises = [
        ExerciseDM(
          id: 'ex1',
          exercise: 'Push Up',
          difficultyLevel: 'Beginner',
          shortYoutubeDemonstrationLink: 'https://youtube.com/1',
          targetMuscleGroup: 'Chest',
          primeMoverMuscle: 'Pectorals',
          bodyRegion: 'sdas',
          secondaryItems: 22,
          combinationExercises: 'dsasd',
          continuousOrAlternatingArms: 'dasad',
          continuousOrAlternatingLegs: 'dadsa',
          footElevation: 'dasdsa',
          forceType: 'das',
          grip: 'adsd',
          laterality: 'dadsa',
          loadPositionEnding: 'd',
          shortYoutubeDemonstration: 'dss',
          primaryEquipment: 'dasdsa',
          primaryItems: 22,
          mechanics: 'dsasdas',
          movementPattern1: 'dsasd',
          planeOfMotion1: 'dasa',
          posture: 'dasa',
          primaryExerciseClassification: 'dsaas',
          singleOrDoubleArm: 'asdsa',
          inDepthYoutubeExplanation: 'dasdas',
          inDepthYoutubeExplanationLink: 'dasdsa',
          movementPattern2: 'adsa',
          movementPattern3: 'dsaasd',
          planeOfMotion2: 'dassda',
          planeOfMotion3: 'dsaas',
          secondaryEquipment: 'dasda',
          secondaryMuscle: 'sdasd',
          tertiaryMuscle: 'dasdsa',
        ),
        ExerciseDM(
          id: 'ex2',
          exercise: 'Sit Up',
          difficultyLevel: 'Beginner',
          shortYoutubeDemonstrationLink: 'https://youtube.com/2',
          targetMuscleGroup: 'Core',
          primeMoverMuscle: 'Abdominals',
          bodyRegion: 'sdas',
          secondaryItems: 22,
          combinationExercises: 'dsasd',
          continuousOrAlternatingArms: 'dasad',
          continuousOrAlternatingLegs: 'dadsa',
          footElevation: 'dasdsa',
          forceType: 'das',
          grip: 'adsd',
          laterality: 'dadsa',
          loadPositionEnding: 'd',
          shortYoutubeDemonstration: 'dss',
          primaryEquipment: 'dasdsa',
          primaryItems: 22,
          mechanics: 'dsasdas',
          movementPattern1: 'dsasd',
          planeOfMotion1: 'dasa',
          posture: 'dasa',
          primaryExerciseClassification: 'dsaas',
          singleOrDoubleArm: 'asdsa',
          inDepthYoutubeExplanation: 'dasdas',
          inDepthYoutubeExplanationLink: 'dasdsa',
          movementPattern2: 'adsa',
          movementPattern3: 'dsaasd',
          planeOfMotion2: 'dassda',
          planeOfMotion3: 'dsaas',
          secondaryEquipment: 'dasda',
          secondaryMuscle: 'sdasd',
          tertiaryMuscle: 'dasdsa',
        ),
      ];

      test(
        'should return ApiSuccess when remote data source succeeds',
        () async {
          when(
            mockExerciseRemoteDs.getExercises(
              levelId: levelId,
              muscleGroupId: muscleGroupId,
              page: page,
            ),
          ).thenAnswer((_) async => ApiSuccess(mockExercises));

          final result = await exerciseRepo.fetchExercises(
            levelId: levelId,
            muscleGroupId: muscleGroupId,
            page: page,
          );

          expect(result, isA<ApiSuccess<List<ExerciseDM>>>());
          final exercises = (result as ApiSuccess<List<ExerciseDM>>).data;
          expect(exercises.length, equals(2));
          expect(exercises.first.id, equals('ex1'));
          expect(exercises.last.id, equals('ex2'));

          verify(
            mockExerciseRemoteDs.getExercises(
              levelId: levelId,
              muscleGroupId: muscleGroupId,
              page: page,
            ),
          ).called(1);
        },
      );

      test('should return ApiFailure when remote data source fails', () async {
        const errorMessage = 'Network error';
        when(
          mockExerciseRemoteDs.getExercises(
            levelId: levelId,
            muscleGroupId: muscleGroupId,
            page: page,
          ),
        ).thenAnswer((_) async => const ApiFailure(errorMessage));

        final result = await exerciseRepo.fetchExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: page,
        );

        expect(result, isA<ApiFailure<List<ExerciseDM>>>());
        expect(
          (result as ApiFailure<List<ExerciseDM>>).message,
          equals(errorMessage),
        );
      });

      test('should pass null page parameter correctly', () async {
        when(
          mockExerciseRemoteDs.getExercises(
            levelId: levelId,
            muscleGroupId: muscleGroupId,
            page: null,
          ),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));

        final result = await exerciseRepo.fetchExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: null,
        );

        expect(result, isA<ApiSuccess<List<ExerciseDM>>>());
      });

      test('should handle empty exercise list from data source', () async {
        when(
          mockExerciseRemoteDs.getExercises(
            levelId: levelId,
            muscleGroupId: muscleGroupId,
            page: page,
          ),
        ).thenAnswer((_) async => const ApiSuccess(<ExerciseDM>[]));

        final result = await exerciseRepo.fetchExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: page,
        );

        expect(result, isA<ApiSuccess<List<ExerciseDM>>>());
        expect((result as ApiSuccess<List<ExerciseDM>>).data, isEmpty);
      });

      test('should pass all parameters correctly to data source', () async {
        const customLevelId = 'custom_level';
        const customMuscleGroupId = 'custom_muscle';
        const customPage = 5;

        when(
          mockExerciseRemoteDs.getExercises(
            levelId: customLevelId,
            muscleGroupId: customMuscleGroupId,
            page: customPage,
          ),
        ).thenAnswer((_) async => ApiSuccess(mockExercises));

        await exerciseRepo.fetchExercises(
          levelId: customLevelId,
          muscleGroupId: customMuscleGroupId,
          page: customPage,
        );

        verify(
          mockExerciseRemoteDs.getExercises(
            levelId: customLevelId,
            muscleGroupId: customMuscleGroupId,
            page: customPage,
          ),
        ).called(1);
      });
    });

    group('fetchLevels', () {
      final mockLevels = [
        DifficultyLevelDM(id: 'level1', name: 'Beginner'),
        DifficultyLevelDM(id: 'level2', name: 'Intermediate'),
        DifficultyLevelDM(id: 'level3', name: 'Advanced'),
      ];

      test(
        'should return ApiSuccess when remote data source succeeds',
        () async {
          when(
            mockExerciseRemoteDs.getLevels(),
          ).thenAnswer((_) async => ApiSuccess(mockLevels));

          final result = await exerciseRepo.fetchLevels();

          expect(result, isA<ApiSuccess<List<DifficultyLevelDM>>>());
          final levels = (result as ApiSuccess<List<DifficultyLevelDM>>).data;
          expect(levels.length, equals(3));
          expect(levels.first.id, equals('level1'));
        },
      );

      test('should return ApiFailure when remote data source fails', () async {
        const errorMessage = 'Server error';
        when(
          mockExerciseRemoteDs.getLevels(),
        ).thenAnswer((_) async => const ApiFailure(errorMessage));

        final result = await exerciseRepo.fetchLevels();

        expect(result, isA<ApiFailure<List<DifficultyLevelDM>>>());
        expect(
          (result as ApiFailure<List<DifficultyLevelDM>>).message,
          equals(errorMessage),
        );
      });

      test('should handle empty levels list from data source', () async {
        when(
          mockExerciseRemoteDs.getLevels(),
        ).thenAnswer((_) async => const ApiSuccess(<DifficultyLevelDM>[]));

        final result = await exerciseRepo.fetchLevels();

        expect(result, isA<ApiSuccess<List<DifficultyLevelDM>>>());
        expect((result as ApiSuccess<List<DifficultyLevelDM>>).data, isEmpty);
      });

      test('should call remote data source exactly once', () async {
        when(
          mockExerciseRemoteDs.getLevels(),
        ).thenAnswer((_) async => ApiSuccess(mockLevels));

        await exerciseRepo.fetchLevels();
        await exerciseRepo.fetchLevels();

        verify(mockExerciseRemoteDs.getLevels()).called(2);
      });
    });

    group('Integration scenarios', () {
      test(
        'should maintain consistency between different method calls',
        () async {
          final mockLevels = [
            DifficultyLevelDM(id: 'level1', name: 'Beginner'),
          ];
          final mockExercises = [
            ExerciseDM(
              id: 'ex1',
              exercise: 'Push Up',
              difficultyLevel: 'Beginner',
              shortYoutubeDemonstrationLink: 'https://youtube.com/1',
              targetMuscleGroup: 'Chest',
              primeMoverMuscle: 'Pectorals',
              bodyRegion: 'sdas',
              secondaryItems: 22,
              combinationExercises: 'dsasd',
              continuousOrAlternatingArms: 'dasad',
              continuousOrAlternatingLegs: 'dadsa',
              footElevation: 'dasdsa',
              forceType: 'das',
              grip: 'adsd',
              laterality: 'dadsa',
              loadPositionEnding: 'd',
              shortYoutubeDemonstration: 'dss',
              primaryEquipment: 'dasdsa',
              primaryItems: 22,
              mechanics: 'dsasdas',
              movementPattern1: 'dsasd',
              planeOfMotion1: 'dasa',
              posture: 'dasa',
              primaryExerciseClassification: 'dsaas',
              singleOrDoubleArm: 'asdsa',
              inDepthYoutubeExplanation: 'dasdas',
              inDepthYoutubeExplanationLink: 'dasdsa',
              movementPattern2: 'adsa',
              movementPattern3: 'dsaasd',
              planeOfMotion2: 'dassda',
              planeOfMotion3: 'dsaas',
              secondaryEquipment: 'dasda',
              secondaryMuscle: 'sdasd',
              tertiaryMuscle: 'dasdsa',
            ),
          ];

          when(
            mockExerciseRemoteDs.getLevels(),
          ).thenAnswer((_) async => ApiSuccess(mockLevels));
          when(
            mockExerciseRemoteDs.getExercises(
              levelId: 'level1',
              muscleGroupId: 'muscle1',
              page: 1,
            ),
          ).thenAnswer((_) async => ApiSuccess(mockExercises));

          final levelsResult = await exerciseRepo.fetchLevels();
          final exercisesResult = await exerciseRepo.fetchExercises(
            levelId: 'level1',
            muscleGroupId: 'muscle1',
            page: 1,
          );

          expect(levelsResult, isA<ApiSuccess<List<DifficultyLevelDM>>>());
          expect(exercisesResult, isA<ApiSuccess<List<ExerciseDM>>>());
        },
      );
    });
  });
}
