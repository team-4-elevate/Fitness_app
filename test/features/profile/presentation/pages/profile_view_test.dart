// import 'dart:async';

// import 'package:fitness_app/core/app_data/app_bloc.dart';
// import 'package:fitness_app/core/app_data/app_states.dart';
// import 'package:fitness_app/core/services/localization_manager.dart';
// import 'package:fitness_app/core/widgets/app_network_image.dart';
// import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
// import 'package:fitness_app/features/profile/presentation/bloc/profile_bloc.dart';
// import 'package:fitness_app/features/profile/presentation/bloc/profile_event.dart';
// import 'package:fitness_app/features/profile/presentation/pages/profile_view.dart';
// import 'package:fitness_app/features/profile/presentation/widgets/profile_custom_row.dart';
// import 'package:fitness_app/generated/l10n/app_localizations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import 'profile_view_test.mocks.dart';

// @GenerateMocks([ProfileBloc, AppBloc, LocalizationManager, NavigatorObserver])
// void main() {
//   late MockProfileBloc mockProfileBloc;
//   late MockAppBloc mockAppBloc;
//   late MockLocalizationManager mockLocalizationManager;
//   late MockNavigatorObserver mockNavigatorObserver;

//   late StreamController<AppState> appStreamController;
//   late StreamController<ProfileState> profileStreamController;

//   setUp(() {
//     mockProfileBloc = MockProfileBloc();
//     mockAppBloc = MockAppBloc();
//     mockLocalizationManager = MockLocalizationManager();
//     mockNavigatorObserver = MockNavigatorObserver();
//     when(mockProfileBloc.state).thenReturn(const ProfileState());

//     appStreamController = StreamController<AppState>.broadcast();
//     profileStreamController = StreamController<ProfileState>.broadcast();

//     when(mockAppBloc.stream).thenAnswer((_) => appStreamController.stream);
//     when(mockProfileBloc.stream)
//         .thenAnswer((_) => profileStreamController.stream);

//     // Mock navigator method - required for the NavigatorObserver
//     when(mockNavigatorObserver.navigator).thenReturn(null);

//     // Mock the state for the AppBloc
//     when(mockAppBloc.state).thenReturn(AppState(
//       cachedUserData: User(
//         firstName: 'John',
//         lastName: 'Doe',
//         photo: 'https://example.com/photo.jpg',
//       ),
//     ));

//     when(mockLocalizationManager.isEnglish).thenReturn(true);

//     Provider.debugCheckInvalidValueType = null;
//   });

//   tearDown(() {
//     Provider.debugCheckInvalidValueType = null;
//     appStreamController.close();
//     profileStreamController.close();
//   });

//   // Create a testable widget with necessary dependencies
//   Widget createTestableWidget({User? userData}) {
//     userData ??= User(
//       firstName: 'John',
//       lastName: 'Doe',
//       photo: 'https://example.com/photo.jpg',
//     );

//     when(mockAppBloc.state).thenReturn(AppState(cachedUserData: userData));
//     when(mockLocalizationManager.isEnglish).thenReturn(true);

//     return MaterialApp(
//       key: UniqueKey(),
//       home: SingleChildScrollView(
//         child: MultiProvider(
//           providers: [
//             BlocProvider<ProfileBloc>.value(value: mockProfileBloc),
//             BlocProvider<AppBloc>.value(value: mockAppBloc),
//             Provider<LocalizationManager>.value(value: mockLocalizationManager),
//           ],
//           child: const ProfileView(),
//         ),
//       ),
//       localizationsDelegates: const [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: const [Locale('en')],
//       navigatorObservers: [mockNavigatorObserver],
//     );
//   }

//   testWidgets('renders user name correctly', (WidgetTester tester) async {
//     debugDisableShadows = true;

//     await tester.pumpWidget(createTestableWidget());

//     await tester.pump();
//     await tester.pump(const Duration(milliseconds: 500));

//     expect(find.text('John Doe'), findsOneWidget);
//   });

//   testWidgets('shows profile picture', (WidgetTester tester) async {
//     await tester.pumpWidget(createTestableWidget());
//     await tester.pump(const Duration(seconds: 1));

//     expect(find.byType(AppNetworkImage), findsOneWidget);
//   });

//   testWidgets('contains profile rows', (WidgetTester tester) async {
//     await tester.pumpWidget(createTestableWidget());
//     await tester.pump(const Duration(seconds: 1));

//     expect(find.byType(ProfileCustomRow), findsWidgets);
//   });
// }
