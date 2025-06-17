// main.dart
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/utils/navigation_services.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view.dart';
import 'package:fitness_app/features/auth/presentation/login/login_view_model.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/services/api_localization_service.dart';
import 'core/services/localization_manager.dart';
import 'core/responsive/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiLocalizationService().init();
  await LocalizationManager().initialize();
  configureDependencies();
  await _configureFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocalizationManager(),
      child: Consumer<LocalizationManager>(
        builder: (context, localizationManager, child) {
          return ResponsiveWrapper(
            child: MaterialApp(
              title: 'Fitness App',
              navigatorKey: getIt<NavigationService>().navigatorKey,

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
              // Builder to set up localization service with context
              builder: (context, child) {
                final localizations = AppLocalizations.of(context);
                ApiLocalizationService().setLocalizations(localizations);
                return child!;
              },
              // routes: {'/home': (context) => const Home()},

              //home: const Home(),
              home: BlocProvider(
                create: (context) => getIt<LoginViewModel>(),
                child: const LoginView(),
              ),
            ),
          );
        },
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
