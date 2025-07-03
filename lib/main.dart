// main.dart

// Dart imports
import 'dart:isolate';
import 'dart:ui';

// Third-party imports
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Project-specific imports
import 'package:fitness_app/core/app_bloc_observer.dart';
import 'package:fitness_app/core/app_data/app_bloc.dart';
import 'package:fitness_app/core/app_data/app_events.dart';
import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/hive/hive_config.dart';
import 'package:fitness_app/core/responsive/responsive.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/routes/app_routes_generator.dart';
import 'package:fitness_app/core/services/api_localization_service.dart';
import 'package:fitness_app/core/services/localization_manager.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';

// Global variables
bool isShowOnboarding = false;
bool shouldAutoLogin = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  Bloc.observer = AppBlocObserver();

  runApp(
    BlocProvider(
      create: (context) => getIt<AppBloc>()..add(GetCachedUserDataEvent()),
      child: const MyApp(),
    ),
  );
}

Future<void> _initializeApp() async {
  await configureDependencies();
  await Future.wait([
    _setAutoLogin(),
    ApiLocalizationService().init(),
    getIt<LocalizationManager>().initialize(),
    _configureFirebase(),
    getIt<HiveService>().init(),
  ]);
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

Future<void> _setAutoLogin() async {
  if (await getIt<AppSecureStorage>().getToken() != null) {
    shouldAutoLogin = true;
    return;
  }
  isShowOnboarding = await getIt<AppLocalStorage>().isShowOnboarding();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<LocalizationManager>(),
      child: Consumer<LocalizationManager>(
        builder: (context, localizationManager, child) {
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
              supportedLocales: localizationManager.supportedLocales,
              locale: localizationManager.currentLocale,
              theme: AppTheme.lightTheme,
              onGenerateRoute: AppRoutesGenerator.generateRoute,
              builder: (context, child) {
                final localizations = AppLocalizations.of(context);
                ApiLocalizationService().setLocalizations(localizations);
                return child!;
              },
              initialRoute: _setInitialRoute(),
            ),
          );
        },
      ),
    );
  }

  String _setInitialRoute() {
    if (shouldAutoLogin) return AppRoutes.layoutScreen;
    return isShowOnboarding ? AppRoutes.loginPage : AppRoutes.onboarding;
  }
}
