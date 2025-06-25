import 'package:fitness_app/features/app_sections/AppSections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/features/app_sections/ChatAipage.dart';
import 'package:fitness_app/features/app_sections/Workouts_Page/presentation/pages/Workouts.dart';
import 'package:fitness_app/features/app_sections/HomePage.dart';
import 'package:fitness_app/features/app_sections/ProfilePage.dart';

void main() {
  group('MainNavigationScreen Tests', () {
    testWidgets('Initial page is HomePage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainNavigationScreen()));

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
    });

    testWidgets('Navigate to ChatAipage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainNavigationScreen()));
      await tester.tap(find.byKey(Key('nav_icon_chatai')));
      await tester.pumpAndSettle();
      expect(find.byType(ChatAipage), findsOneWidget);
      expect(find.byType(ChatAipage), findsNothing);
    });

    testWidgets('Navigate to GymPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainNavigationScreen()));
      await tester.tap(find.byKey(Key('nav_icon_gym')));
      await tester.pumpAndSettle();
      expect(find.byType(Workouts), findsOneWidget);
      expect(find.byType(Workouts), findsNothing);
    });

    testWidgets('Navigate to ProfilePage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainNavigationScreen()));
      await tester.tap(find.byKey(Key('nav_icon_profile')));
      await tester.pumpAndSettle();
      expect(find.byType(ProfilePage), findsOneWidget);
      expect(find.byType(ProfilePage), findsNothing);
    });
  });
}
