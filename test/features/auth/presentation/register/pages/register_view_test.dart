// test/features/auth/presentation/register/pages/register_view_test.dart
import 'package:fitness_app/features/auth/presentation/register/widget/password_strength_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/user.dart';
import 'package:fitness_app/core/routes/app_routes.dart';

import 'register_view_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RegisterBloc>(),
  MockSpec<NavigatorObserver>(),
]) // Using GenerateNiceMocks for better handling of unstubbed methods
// Create dummy response for Mockito
final dummyResponse = RegisterResponse(
  message: 'Dummy response',
  token: 'dummy_token',
  user: User(),
);

void main() {
  final testViewport = const Size(1000, 1000);

  debugPrintLayouts = false;
  //  dummy values for mockito
  provideDummy<BaseState<RegisterResponse>>(
    BaseInitialState<RegisterResponse>(),
  );
  provideDummy<RegisterStateType>(const BaseInitialState<RegisterResponse>());
  late MockRegisterBloc mockRegisterBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockNavigatorObserver = MockNavigatorObserver();
    reset(mockRegisterBloc);
    reset(mockNavigatorObserver);
    when(mockRegisterBloc.state).thenReturn(BaseInitialState());
  });

  Widget createRegisterView() {
    return MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      home: MediaQuery(
        data: MediaQueryData(size: testViewport),
        child: BlocProvider<RegisterBloc>.value(
          value: mockRegisterBloc,
          child: const RegisterView(),
        ),
      ),
      routes: {AppRoutes.registerDetailsView: (context) => Container()},
    );
  }

  group('RegisterView UI Tests', () {
    testWidgets('should display all required fields and title', (
      WidgetTester tester,
    ) async {
      /// Arrange & Act
      await tester.pumpWidget(createRegisterView());
      await tester.pumpAndSettle();

      /// Assert - Check for title and form sections
      expect(find.text('Create An Account'), findsOneWidget);
      expect(find.text('Hi there'), findsOneWidget);

      /// Check for form fields - there should be 4 text form fields
      expect(find.byType(TextFormField), findsNWidgets(4));

      /// Check for specific field labels/hints with hintText
      expect(find.widgetWithText(TextFormField, 'First Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Last Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      ///Register button
      expect(find.text('Register'), findsOneWidget);
    });

    //------------------------------- Test for the first name field
    testWidgets(
      'should show password strength indicator when password entered',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createRegisterView());
        await tester.pumpAndSettle();

        // Act
        final passwordField = find.widgetWithText(TextFormField, 'Password');
        await tester.enterText(passwordField, 'Test@123');
        await tester.pump();

        // Assert
        expect(find.byType(PasswordStrengthIndicator), findsOneWidget);
      },
    );

    //------------------------------- Test for validation errors
    testWidgets('should show validation errors when form is submitted empty', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(createRegisterView());
      await tester.pumpAndSettle();

      // Register button
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.ensureVisible(registerButton);
      await tester.pumpAndSettle();

      /// Act
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      /// Wait for debugging
      await tester.pump(const Duration(milliseconds: 500));

      /// Assert - Check for validation error messages
      expect(
        find.textContaining('First name is required'),
        findsAtLeastNWidgets(1),
      );
      expect(
        find.textContaining('Last name is required'),
        findsAtLeastNWidgets(1),
      );
      expect(find.textContaining('Email is required'), findsAtLeastNWidgets(1));
      expect(find.textContaining('Password'), findsAtLeastNWidgets(1));
    });

    //------------------------------- Test for valid form submission
    testWidgets('should navigate to details page when form is valid', (
      WidgetTester tester,
    ) async {
      clearInteractions(mockNavigatorObserver);

      when(mockRegisterBloc.stream).thenAnswer(
        (_) => Stream.value(SuccessState<RegisterResponse>(dummyResponse)),
      );

      // Arrange
      await tester.pumpWidget(createRegisterView());
      await tester.pumpAndSettle();
      // Act
      await tester.enterText(
        find.widgetWithText(TextFormField, 'First Name'),
        'John',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Last Name'),
        'Doe',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'john.doe@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test@123',
      );
      await tester.pumpAndSettle();

      clearInteractions(mockNavigatorObserver);

      // Find and tap the register button
      final registerButton = find.widgetWithText(ElevatedButton, 'Register');
      await tester.ensureVisible(registerButton);
      await tester.pumpAndSettle();
      await tester.tap(registerButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      // Verify navigation occurred after form submission
      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    });

    //------------------------------- Test for password visibility toggle
    testWidgets('should toggle password visibility when eye icon is tapped', (
      WidgetTester tester,
    ) async {
      /// Arrange
      await tester.pumpWidget(createRegisterView());
      await tester.pumpAndSettle();

      ///  password field
      final passwordField = find.widgetWithText(TextFormField, 'Password');
      await tester.ensureVisible(passwordField);
      await tester.pumpAndSettle();

      /// Enter text in the password field
      await tester.enterText(passwordField, 'Test@123');
      await tester.pumpAndSettle();

      /// Find the eye icon and ensure it's visible
      final gestureFinder = find.descendant(
        of: passwordField,
        matching: find.byType(GestureDetector),
      );
      await tester.ensureVisible(gestureFinder.first);
      await tester.pumpAndSettle();

      // the eye icon with warnIfMissed: false to suppress warnings
      await tester.tap(gestureFinder.first, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(gestureFinder, findsWidgets);
    });
  });
}
