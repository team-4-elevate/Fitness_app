import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/features/exercise/domain/arguments/exercise_page_arguments.dart';
import 'package:fitness_app/features/exercise/domain/entites/difficulty_level.dart';
import 'package:fitness_app/features/exercise/domain/entites/exercise_entity.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_event.dart';
import 'package:fitness_app/features/exercise/presentation/bloc/exercise_state.dart';
import 'package:fitness_app/features/exercise/presentation/view/exercise_page/exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';

@GenerateMocks([ExercisePageBloc])
import 'exercise_page_test.mocks.dart';

void main() {
  late MockExercisePageBloc mockBloc;

  setUp(() {
    mockBloc = MockExercisePageBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<ExercisePageBloc>.value(
        value: mockBloc,
        child: ExercisePage(
          arguments: ExercisePageArguments(
            muscleGroupId: 'muscle1',
            muscleGroupName: 'Chest',
            muscleGroupImage: 'assets/images/chest.png',
          ),
        ),
      ),
    );
  }

  group('ExercisePage Widget Tests', () {
    testWidgets('should display header with muscle group name', (
      WidgetTester tester,
    ) async {
      when(mockBloc.state).thenReturn(const ExercisePageState());
      when(
        mockBloc.stream,
      ).thenAnswer((_) => Stream.value(const ExercisePageState()));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Chest Exercise'), findsOneWidget);
    });

    testWidgets('should display exercises when loaded successfully', (
      WidgetTester tester,
    ) async {
      final mockLevels = [
        DifficultyLevelEntity(id: 'level1', name: 'Beginner'),
        DifficultyLevelEntity(id: 'level2', name: 'Intermediate'),
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
          name: 'Bench Press',
          difficulty: 'Intermediate',
          youtubeLink: 'https://youtube.com/watch?v=2',
          targetMuscleGroup: 'Chest',
          primeMoverMuscle: 'Pectorals',
        ),
      ];

      final state = ExercisePageState(
        getLevelsStatus: Status.success,
        getExercisesStatus: Status.success,
        levelExerciseMap: {
          mockLevels[0]: mockExercises,
          mockLevels[1]: <ExerciseEntity>[],
        },
        currentLevelId: 'level1',
        levelIdAndPagesMap: {'level1': 1, 'level2': 1},
      );

      when(mockBloc.state).thenReturn(state);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Chest Exercise'), findsOneWidget);
    });

    testWidgets('should display error message when loading fails', (
      WidgetTester tester,
    ) async {
      when(mockBloc.state).thenReturn(
        const ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.error,
          errorMessage: 'Failed to load exercises',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Failed to load exercises'), findsOneWidget);
    });

    testWidgets('should display empty state when no exercises found', (
      WidgetTester tester,
    ) async {
      final mockLevels = [
        DifficultyLevelEntity(id: 'level1', name: 'Beginner'),
      ];

      when(mockBloc.state).thenReturn(
        ExercisePageState(
          getLevelsStatus: Status.success,
          getExercisesStatus: Status.success,
          levelExerciseMap: {mockLevels[0]: <ExerciseEntity>[]},
          currentLevelId: 'level1',
          levelIdAndPagesMap: {'level1': 1},
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No exercises found'), findsOneWidget);
    });
  });
}
