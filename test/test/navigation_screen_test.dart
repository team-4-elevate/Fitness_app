import 'package:fitness_app/features/app_sections/AppSections.dart';
import 'package:fitness_app/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/features/app_sections/ChatAipage.dart';
import 'package:fitness_app/features/app_sections/GymPage.dart';
import 'package:fitness_app/features/app_sections/ProfilePage.dart';

void main() {
  group('MainNavigationScreen Tests', () {
    testWidgets('Initial page is HomePage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MainNavigationScreen()));

      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(Home), findsNothing);
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
      expect(find.byType(GymPage), findsOneWidget);
      expect(find.byType(GymPage), findsNothing);
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
