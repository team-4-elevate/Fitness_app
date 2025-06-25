import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/features/exercise/data/data_sources/remote/exercise_remote_ds_impl.dart';
import 'package:fitness_app/features/exercise/data/data_sources/remote/exercise_remote_ds_interface.dart';
import 'package:fitness_app/features/exercise/data/models/difficulty_level/model/difficulty_level_dm.dart';
import 'package:fitness_app/features/exercise/data/models/exercise/model/exercise_dm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'exercise_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ExerciseRemoteDsInterface exerciseRemoteDs;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    exerciseRemoteDs = ExerciseRemoteDsImpl(mockApiClient);

    provideDummy<ApiResult<dynamic>>(const ApiSuccess<dynamic>(null));
  });

  group('ExerciseRemoteDs', () {
    group('getExercises', () {
      const levelId = 'level1';
      const muscleGroupId = 'muscle1';
      const page = 1;

      final mockExerciseData = {
        'message': 'Success',
        'totalExercises': 2,
        'totalPages': 1,
        'currentPage': 1,
        'exercises': [
          {
            '_id': 'ex1',
            'exercise': 'Push Up',
            'difficulty_level': 'Beginner',
            'short_youtube_demonstration_link': 'https://youtube.com/watch?v=1',
            'target_muscle_group': 'Chest',
            'prime_mover_muscle': 'Pectorals',
            'short_youtube_demonstration': 'demo1',
            'primary_equipment': 'None',
            '_primary_items': 0,
            '_secondary_items': 0,
            'posture': 'Standing',
            'single_or_double_arm': 'Double',
            'continuous_or_alternating_arms': 'Continuous',
            'grip': 'Standard',
            'load_position_ending': 'End',
            'continuous_or_alternating_legs': 'Continuous',
            'foot_elevation': 'None',
            'combination_exercises': 'None',
            'movement_pattern_1': 'Push',
            'plane_of_motion_1': 'Sagittal',
            'body_region': 'Upper',
            'force_type': 'Push',
            'mechanics': 'Compound',
            'laterality': 'Bilateral',
            'primary_exercise_classification': 'Strength',
          },
          {
            '_id': 'ex2',
            'exercise': 'Sit Up',
            'difficulty_level': 'Beginner',
            'short_youtube_demonstration_link': 'https://youtube.com/watch?v=2',
            'target_muscle_group': 'Core',
            'prime_mover_muscle': 'Abdominals',
            'short_youtube_demonstration': 'demo2',
            'primary_equipment': 'None',
            '_primary_items': 0,
            '_secondary_items': 0,
            'posture': 'Lying',
            'single_or_double_arm': 'Double',
            'continuous_or_alternating_arms': 'Continuous',
            'grip': 'None',
            'load_position_ending': 'End',
            'continuous_or_alternating_legs': 'Continuous',
            'foot_elevation': 'None',
            'combination_exercises': 'None',
            'movement_pattern_1': 'Crunch',
            'plane_of_motion_1': 'Sagittal',
            'body_region': 'Core',
            'force_type': 'Pull',
            'mechanics': 'Compound',
            'laterality': 'Bilateral',
            'primary_exercise_classification': 'Strength',
          },
        ],
      };

      test(
        'should return ApiSuccess with exercises when API call succeeds',
        () async {
          when(
            mockApiClient.get(
              ApiConstants.exercises,
              queryParameters: {
                'primeMoverMuscleId': muscleGroupId,
                'difficultyLevelId': levelId,
                'page': page,
              },
            ),
          ).thenAnswer((_) async => ApiSuccess(mockExerciseData));

          final result = await exerciseRemoteDs.getExercises(
            levelId: levelId,
            muscleGroupId: muscleGroupId,
            page: page,
          );

          expect(result, isA<ApiSuccess<List<ExerciseDM>>>());

          final exercises = (result as ApiSuccess<List<ExerciseDM>>).data;
          expect(exercises.length, equals(2));
          expect(exercises.first.id, equals('ex1'));
          expect(exercises.first.exercise, equals('Push Up'));
          expect(exercises.last.id, equals('ex2'));
          expect(exercises.last.exercise, equals('Sit Up'));

          verify(
            mockApiClient.get(
              ApiConstants.exercises,
              queryParameters: {
                'primeMoverMuscleId': muscleGroupId,
                'difficultyLevelId': levelId,
                'page': page,
              },
            ),
          ).called(1);
        },
      );

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Network error';
        when(
          mockApiClient.get(
            ApiConstants.exercises,
            queryParameters: {
              'primeMoverMuscleId': muscleGroupId,
              'difficultyLevelId': levelId,
              'page': page,
            },
          ),
        ).thenAnswer((_) async => const ApiFailure(errorMessage));

        final result = await exerciseRemoteDs.getExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: page,
        );

        expect(result, isA<ApiFailure<List<ExerciseDM>>>());
        expect(
          (result as ApiFailure<List<ExerciseDM>>).message,
          equals(errorMessage),
        );

        verify(
          mockApiClient.get(
            ApiConstants.exercises,
            queryParameters: {
              'primeMoverMuscleId': muscleGroupId,
              'difficultyLevelId': levelId,
              'page': page,
            },
          ),
        ).called(1);
      });

      test('should handle null page parameter correctly', () async {
        when(
          mockApiClient.get(
            ApiConstants.exercises,
            queryParameters: {
              'primeMoverMuscleId': muscleGroupId,
              'difficultyLevelId': levelId,
              'page': null,
            },
          ),
        ).thenAnswer((_) async => ApiSuccess(mockExerciseData));

        final result = await exerciseRemoteDs.getExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: null,
        );

        expect(result, isA<ApiSuccess<List<ExerciseDM>>>());

        verify(
          mockApiClient.get(
            ApiConstants.exercises,
            queryParameters: {
              'primeMoverMuscleId': muscleGroupId,
              'difficultyLevelId': levelId,
              'page': null,
            },
          ),
        ).called(1);
      });

      test('should handle empty exercises list', () async {
        final emptyExerciseData = {
          'message': 'Success',
          'totalExercises': 0,
          'totalPages': 0,
          'currentPage': 1,
          'exercises': <Map<String, dynamic>>[],
        };
        when(
          mockApiClient.get(
            ApiConstants.exercises,
            queryParameters: {
              'primeMoverMuscleId': muscleGroupId,
              'difficultyLevelId': levelId,
              'page': page,
            },
          ),
        ).thenAnswer((_) async => ApiSuccess(emptyExerciseData));

        final result = await exerciseRemoteDs.getExercises(
          levelId: levelId,
          muscleGroupId: muscleGroupId,
          page: page,
        );

        expect(result, isA<ApiSuccess<List<ExerciseDM>>>());
        final exercises = (result as ApiSuccess<List<ExerciseDM>>).data;
        expect(exercises, isEmpty);
      });
    });

    group('getLevels', () {
      final mockLevelsData = {
        'message': 'Success',
        'levels': [
          {'_id': 'level1', 'name': 'Beginner'},
          {'_id': 'level2', 'name': 'Intermediate'},
          {'_id': 'level3', 'name': 'Advanced'},
        ],
      };

      test(
        'should return ApiSuccess with difficulty levels when API call succeeds',
        () async {
          when(
            mockApiClient.get(ApiConstants.difficultyLevel),
          ).thenAnswer((_) async => ApiSuccess(mockLevelsData));

          final result = await exerciseRemoteDs.getLevels();

          expect(result, isA<ApiSuccess<List<DifficultyLevelDM>>>());

          final levels = (result as ApiSuccess<List<DifficultyLevelDM>>).data;
          expect(levels.length, equals(3));
          expect(levels.first.id, equals('level1'));
          expect(levels.first.name, equals('Beginner'));
          expect(levels.last.id, equals('level3'));
          expect(levels.last.name, equals('Advanced'));

          verify(mockApiClient.get(ApiConstants.difficultyLevel)).called(1);
        },
      );

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Server error';
        when(
          mockApiClient.get(ApiConstants.difficultyLevel),
        ).thenAnswer((_) async => const ApiFailure(errorMessage));

        final result = await exerciseRemoteDs.getLevels();

        expect(result, isA<ApiFailure<List<DifficultyLevelDM>>>());
        expect(
          (result as ApiFailure<List<DifficultyLevelDM>>).message,
          equals(errorMessage),
        );

        verify(mockApiClient.get(ApiConstants.difficultyLevel)).called(1);
      });

      test('should handle empty levels list', () async {
        final emptyLevelsData = {
          'message': 'Success',
          'levels': <Map<String, dynamic>>[],
        };
        when(
          mockApiClient.get(ApiConstants.difficultyLevel),
        ).thenAnswer((_) async => ApiSuccess(emptyLevelsData));

        final result = await exerciseRemoteDs.getLevels();

        expect(result, isA<ApiSuccess<List<DifficultyLevelDM>>>());
        final levels = (result as ApiSuccess<List<DifficultyLevelDM>>).data;
        expect(levels, isEmpty);
      });
    });
  });
}
