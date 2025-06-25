import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/features/exercise/domain/arguments/exercise_page_arguments.dart';
import 'package:fitness_app/features/exercise/presentation/view/widgets/header/exercise_page_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: Scaffold(
        body: ExercisePageHeaderWidget(
          arguments: ExercisePageArguments(
            muscleGroupId: 'muscle1',
            muscleGroupName: 'Chest',
            muscleGroupImage: 'assets/images/chest.png',
          ),
        ),
      ),
    );
  }

  group('ExercisePageHeaderWidget Tests', () {
    testWidgets('should display muscle group name', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Chest Exercise'), findsOneWidget);
    });

    testWidgets('should have a back button', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsOneWidget);
    });
  });
} 