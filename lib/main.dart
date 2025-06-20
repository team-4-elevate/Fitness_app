// main.dart
import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fitness_app/core/app_bloc_observer.dart';
import 'package:fitness_app/core/app_data/app_bloc.dart';
import 'package:fitness_app/core/app_data/app_events.dart';
import 'package:fitness_app/core/app_data/app_states.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/app_routes_generator.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/services/api_localization_service.dart';
import 'core/services/localization_manager.dart';
import 'core/responsive/responsive.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiLocalizationService().init();
  final localizationManager = LocalizationManager();
  await localizationManager.initialize();
  await configureDependencies();
  
  // Manually register the LocalizationManager singleton
  if (!getIt.isRegistered<LocalizationManager>()) {
    getIt.registerSingleton<LocalizationManager>(localizationManager);
  }
  await _configureFirebase();
  
  Bloc.observer = AppBlocObserver();
  
  // Initialize app state before running the app
  final appBloc = getIt<AppBloc>();
  
  // Check login status first and wait for it
  appBloc.add(CheckUserLoginStatusEvent());
  // Wait for the login check to complete
  await Future.delayed(const Duration(milliseconds: 300));
  
  // Add other events
  appBloc.add(GetAppLocaleEvent());
  appBloc.add(CheckOnboardingStatusEvent());
  
  runApp(const FitnessApp());
}

class FitnessApp extends StatefulWidget {
  const FitnessApp({super.key});

  @override
  State<FitnessApp> createState() => _FitnessAppState();
}

class _FitnessAppState extends State<FitnessApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final appBloc = getIt<AppBloc>();
    return BlocProvider.value(
      value: getIt<AppBloc>(),
      child: BlocListener<AppBloc, AppState>(
        listenWhen: (previous, current) => previous.appLocale != current.appLocale,
        listener: (context, state) {
          getIt<LocalizationManager>().setLocale(Locale(state.appLocale));
          setState(() {}); 
        },
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) => 
            previous.isLoggedIn != current.isLoggedIn || 
            previous.isShowOnboarding != current.isShowOnboarding,
          builder: (context, state) {
            return ResponsiveWrapper(
              child: MaterialApp(
                title: 'Fitness App',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                supportedLocales: getIt<LocalizationManager>().supportedLocales,
                locale: getIt<LocalizationManager>().currentLocale,
                theme: AppTheme.lightTheme,
                onGenerateRoute: AppRoutesGenerator.generateRoute,
                builder: (context, child) {
                  final localizations = AppLocalizations.of(context);
                  ApiLocalizationService().setLocalizations(localizations);
                  return child!;
                },
                initialRoute: !state.isShowOnboarding
                    ? AppRoutes.onboarding
                    : (appBloc.state.isLoggedIn ? AppRoutes.layoutScreen : AppRoutes.loginPage),
              ),
            );
            },
          ),
      ),
    );
  }
}


Future<void> _configureFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
    return true;
  };
  Isolate.current.addErrorListener(
    RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort,
  );
}
