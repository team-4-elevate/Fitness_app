import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage_impl.dart';
import 'package:fitness_app/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final get = GetIt.instance;
void main() {
  setUpAll(() async {
    get.registerLazySingleton<AppSecureStorage>(() => AppSecureStorageImpl());
  });
  Future pumpOnBoardingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: '/',
        routes: {
          '/': (_) => OnBoardingPage(),
          '/login': (_) => const Scaffold(body: Text('Login Page')),
        },
      ),
    );
  }

  group('OnBoardingPage Tests', () {
    testWidgets('should display first page with Next and Skip buttons', (
      tester,
    ) async {
      await pumpOnBoardingPage(tester);

      expect(
        find.text('The Price Of Excellence\n is Discipline'),
        findsOneWidget,
      );
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('should go to second page on Next tap', (tester) async {
      await pumpOnBoardingPage(tester);

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('Fitness Has Never Been So\n Much Fun'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
    });

    testWidgets('should go to third page and show Do IT button', (
      tester,
    ) async {
      await pumpOnBoardingPage(tester);

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      expect(find.text('NO MORE EXCUSES\n Do It Now'), findsOneWidget);
      expect(find.text('Do IT'), findsOneWidget);
    });

    testWidgets(
      'should go back to second page when Back is tapped on third page',
      (tester) async {
        await pumpOnBoardingPage(tester);

        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Back'));
        await tester.pumpAndSettle();

        expect(
          find.text('Fitness Has Never Been So\n Much Fun'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'should go back to first page when Back is tapped on second page',
      (tester) async {
        await pumpOnBoardingPage(tester);

        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Back'));
        await tester.pumpAndSettle();

        expect(
          find.text('The Price Of Excellence\n is Discipline'),
          findsOneWidget,
        );
      },
    );
    testWidgets('should navigate to login page on Skip button tap', (
      tester,
    ) async {
      await pumpOnBoardingPage(tester);

      await tester.tap(find.text('Skip'));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });

    testWidgets('should navigate to login page on Do IT button tap', (
      tester,
    ) async {
      await pumpOnBoardingPage(tester);

      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Do IT'));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });
  });
}
