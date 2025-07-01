import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_state.dart';
import 'package:fitness_app/features/update_password/presentation/view/page/update_password_page.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UpdatePasswordBloc])
import 'update_password_page_test.mocks.dart';

void main() {
  late MockUpdatePasswordBloc mockBloc;

  setUp(() {
    mockBloc = MockUpdatePasswordBloc();
    when(mockBloc.state).thenReturn(const UpdatePasswordState());
    when(mockBloc.stream).thenAnswer((_) => Stream.empty());
  });

  Widget createTestableWidget() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      home: BlocProvider<UpdatePasswordBloc>.value(
        value: mockBloc,
        child: const UpdatePasswordPage(),
      ),
    );
  }

  group('UpdatePasswordPage Widget Tests', () {
    testWidgets('should render basic UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();
      expect(find.text('Update Password'), findsWidgets);
      expect(find.text('Enter your old, new passwords'), findsOneWidget);
    });
  });
} 