import 'package:fitness_app/features/onboarding/domain/usecase/show_onboarding_use_case.dart';
import 'package:fitness_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:fitness_app/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final get = GetIt.instance;

class FakeShowOnboardingUseCase extends Fake implements ShowOnboardingUseCase {
  @override
  Future<void> call() async {}
}

void main() {
  setUpAll(() async {
    get.registerFactory<OnboardingBloc>(
      () => OnboardingBloc(FakeShowOnboardingUseCase()),
    );
  });

  Future pumpOnBoardingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [AppLocalizations.delegate],
        initialRoute: '/',
        routes: {
          '/': (_) => OnBoardingPage(),
          '/login': (_) => const Scaffold(body: Text('Login Page')),
        },
      ),
    );
  }

  Future pumpSecondPage(WidgetTester tester) async {
    await pumpOnBoardingPage(tester);
    final pageViewFinder = find.byType(PageView);
    await tester.drag(pageViewFinder, const Offset(-500, 0));
    await tester.pumpAndSettle();
  }

  Future pumpThirdPage(WidgetTester tester) async {
    await pumpOnBoardingPage(tester);
    final pageViewFinder = find.byType(PageView);
    await tester.drag(pageViewFinder, const Offset(-500, 0));
    await tester.pumpAndSettle();
    await tester.drag(pageViewFinder, const Offset(-500, 0));
    await tester.pumpAndSettle();
  }

  group('Test render items on first page', () {
    testWidgets('renders onboarding image on first page', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byKey(const Key('on_boarding_image_0')), findsOneWidget);
    });

    testWidgets('renders TextButton on first page (Skip)', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders SmoothPageIndicator', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('renders title on first page', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byKey(const Key('on_boarding_title_0')), findsOneWidget);
    });

    testWidgets('renders description on first page', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byKey(const Key('on_boarding_desc_0')), findsOneWidget);
    });

    testWidgets('renders ElevatedButton on first page', (tester) async {
      await pumpOnBoardingPage(tester);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Test render items on second page', () {
    testWidgets('renders onboarding image on second page', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byKey(const Key('on_boarding_image_1')), findsOneWidget);
    });

    testWidgets('renders TextButton on second page (Skip)', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders title on second page', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byKey(const Key('on_boarding_title_1')), findsOneWidget);
    });

    testWidgets('renders description on second page', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byKey(const Key('on_boarding_desc_1')), findsOneWidget);
    });

    testWidgets('renders OutlinedButton on second page', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders ElevatedButton on second page', (tester) async {
      await pumpSecondPage(tester);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('Test render items on third page', () {
    testWidgets('does not renders TextButton on third page (Skip)', (
      tester,
    ) async {
      await pumpThirdPage(tester);

      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('renders onboarding image on third page', (tester) async {
      await pumpThirdPage(tester);

      expect(find.byKey(const Key('on_boarding_image_2')), findsOneWidget);
    });
    testWidgets('renders title on third page', (tester) async {
      await pumpThirdPage(tester);

      expect(find.byKey(const Key('on_boarding_title_2')), findsOneWidget);
    });

    testWidgets('renders description on third page', (tester) async {
      await pumpThirdPage(tester);

      expect(find.byKey(const Key('on_boarding_desc_2')), findsOneWidget);
    });

    testWidgets('renders OutlinedButton on third page', (tester) async {
      await pumpThirdPage(tester);

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders ElevatedButton on third page', (tester) async {
      await pumpThirdPage(tester);

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
  group('swipe test', () {
    testWidgets('swipes from first to second page', (tester) async {
      await pumpOnBoardingPage(tester);

      final pageViewFinder = find.byType(PageView);
      await tester.drag(pageViewFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();

      var secondPage = find.byKey(const Key('secondPageKey'));

      expect(secondPage, findsOneWidget);
    });

    testWidgets('swipes back from second to first page', (tester) async {
      await pumpOnBoardingPage(tester);

      final pageViewFinder = find.byType(PageView);
      await tester.drag(pageViewFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.drag(pageViewFinder, const Offset(500, 0));
      await tester.pumpAndSettle();

      var firstPage = find.byKey(const Key('firstPageKey'));

      expect(firstPage, findsOneWidget);
    });

    testWidgets('swipes to third page', (tester) async {
      await pumpOnBoardingPage(tester);

      final pageViewFinder = find.byType(PageView);
      await tester.drag(pageViewFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.drag(pageViewFinder, const Offset(-500, 0));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const Key('thirdPageKey')));
      var thirdPage = find.byKey(const Key('thirdPageKey'));

      expect(thirdPage, findsOneWidget);
    });
  });
  group('Test Buttons behavior', () {
    testWidgets(
      'should go to second page when (Next) is tapped from first page',
      (tester) async {
        await pumpOnBoardingPage(tester);

        await tester.tap(find.byKey(const Key('first_page_next_button')));
        await tester.pumpAndSettle();

        var secondPage = find.byKey(const Key('secondPageKey'));

        expect(secondPage, findsOneWidget);
      },
    );

    testWidgets(
      'should go to Third page when (Next) is tapped from second page',
      (tester) async {
        await pumpSecondPage(tester);

        await tester.tap(find.byKey(const Key('second_page_next_button')));
        await tester.pumpAndSettle();

        var thirdPage = find.byKey(const Key('thirdPageKey'));

        expect(thirdPage, findsOneWidget);
      },
    );

    testWidgets(
      'should go to second page when (Back) is tapped from third page',
      (tester) async {
        await pumpThirdPage(tester);

        await tester.tap(find.byKey(const Key('third_page_back_button')));
        await tester.pumpAndSettle();

        var secondPage = find.byKey(const Key('secondPageKey'));

        expect(secondPage, findsOneWidget);
      },
    );

    testWidgets(
      'should go back to first page when (Back) is tapped from second page',
      (tester) async {
        await pumpSecondPage(tester);

        await tester.tap(find.byKey(const Key('second_page_back_button')));
        await tester.pumpAndSettle();

        var firstPage = find.byKey(const Key('firstPageKey'));

        expect(firstPage, findsOneWidget);
      },
    );

    testWidgets(
      'should navigate to login page when (Do IT) is tapped on third page',
      (tester) async {
        await pumpThirdPage(tester);

        await tester.tap(find.byKey(const Key('third_page_do_it_button')));
        await tester.pumpAndSettle();

        expect(find.text('Login Page'), findsOneWidget);
      },
    );
    testWidgets('should navigate to login page when (Skip) is tapped', (
      tester,
    ) async {
      await pumpOnBoardingPage(tester);

      await tester.tap(find.byKey(const Key('skip_button')));
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });
  });
}
