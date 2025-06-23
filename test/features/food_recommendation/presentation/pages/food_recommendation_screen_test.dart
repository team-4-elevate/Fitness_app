import 'dart:async';

import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/features/food_recommendation/data/models/meals_categories_response/food_category.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_intent.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_state.dart';
import 'package:fitness_app/features/food_recommendation/presentation/cubit/food_recommendation_viewmodel.dart';
import 'package:fitness_app/features/food_recommendation/presentation/pages/food_recommendation_screen.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_error_view.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_grid_view_widget.dart';
import 'package:fitness_app/features/food_recommendation/presentation/widgets/food_tab_bar_loading.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'food_recommendation_screen_test.mocks.dart';

@GenerateMocks([FoodRecommendationViewModel])
void main() {
  late MockFoodRecommendationViewModel mockViewModel;
  late StreamController<FoodRecommendationState> stateController;

  setUp(() {
    debugDisableShadows = true;
    mockViewModel = MockFoodRecommendationViewModel();
    stateController = StreamController<FoodRecommendationState>.broadcast();

    // Set up default mock behavior with loading state
    when(mockViewModel.state).thenReturn(
      const FoodRecommendationState(
        foodCategoriesState: LoadingState(), 
        mealsByCategoryState: LoadingState(),
      ),
    );
    when(mockViewModel.stream).thenAnswer((_) => stateController.stream);
    when(
      mockViewModel.close(),
    ).thenAnswer((_) async => stateController.close());
    when(mockViewModel.doIntent(any)).thenAnswer((_) async {});
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: BlocProvider<FoodRecommendationViewModel>.value(
        value: mockViewModel,
        child: const FoodRecommendationScreen(),
      ),
    );
  }

  group('FoodRecommendationScreen Basic UI Tests', () {
    testWidgets('should render basic UI structure correctly', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should display correct background image', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Find container with background decoration
      final containerWidget = tester.widget<Container>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).image != null,
        ),
      );

      final decoration = containerWidget.decoration as BoxDecoration;
      final imageDecoration = decoration.image as DecorationImage;
      final assetImage = imageDecoration.image as AssetImage;

      expect(assetImage.assetName, equals(AppConstants.foodBgImage));
      expect(imageDecoration.fit, equals(BoxFit.cover));

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should have transparent scaffold background', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, equals(Colors.transparent));

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('AppBar Tests', () {
    testWidgets('should display correct app bar properties', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Check AppBar properties
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, equals(Colors.transparent));
      expect(appBar.centerTitle, isTrue);
      expect(appBar.elevation, equals(0));

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should display back button with SVG icon', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(SvgPicture), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Loading State Tests', () {
    testWidgets('should display loading grid initially', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      expect(find.byType(FoodGridViewWidget), findsNothing);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should always display categories tab bar', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(FoodTabBarLoading), findsOneWidget);
      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Categories State Tests', () {
    testWidgets('should call doIntent when widget initializes', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      verify(
        mockViewModel.doIntent(const GetMealsCategoriesIntent()),
      ).called(1);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Error State Tests', () {
    testWidgets('should handle error states gracefully', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      // Create error state
      final errorState = FoodRecommendationState(
        foodCategoriesState: ErrorState('Error loading categories'),
      );

      when(mockViewModel.state).thenReturn(errorState);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      expect(find.byType(FoodErrorView), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('State Management Tests', () {
    testWidgets('should handle empty categories list', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      final emptyState = FoodRecommendationState(
        foodCategoriesState: SuccessState(<FoodCategory>[]),
      );

      when(mockViewModel.state).thenReturn(emptyState);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Layout and Responsiveness Tests', () {
    testWidgets('should have correct layout structure', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Check layout components
      expect(find.byType(Column), findsAtLeastNWidgets(1));
      expect(find.byType(Expanded), findsOneWidget);
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should handle small screen sizes', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640); // Small phone
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should render without overflow errors
      expect(find.byType(FoodRecommendationScreen), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should handle landscape orientation', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1920, 1080); // Landscape
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Should maintain layout in landscape
      expect(find.byType(FoodRecommendationScreen), findsOneWidget);
      expect(find.byType(FoodTabBarLoading), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });

  group('Performance Tests', () {
    testWidgets('should handle rapid state changes', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();
      for (int i = 0; i < 5; i++) {
        final state = FoodRecommendationState(
          foodCategoriesState: LoadingState(),
        );
        stateController.add(state);
        await tester.pump(const Duration(milliseconds: 10));
      }

      // Should handle without crashing
      expect(find.byType(FoodRecommendationScreen), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should properly dispose resources', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Remove widget to trigger dispose
      await tester.pumpWidget(Container());
      await tester.pump();

      // Widget should be properly disposed
      expect(find.byType(FoodRecommendationScreen), findsNothing);

      addTearDown(tester.view.resetPhysicalSize);
    });
  });
  
}
