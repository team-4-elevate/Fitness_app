// main.dart
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fitness_app/core/app_bloc_observer.dart';
import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/core/routes/app_routes_generator.dart';
import 'package:fitness_app/core/routes/app_routes.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:fitness_app/core/utils/navigation_services.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_view.dart';
import 'package:fitness_app/firebase_options.dart';
import 'package:fitness_app/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/services/api_localization_service.dart';
import 'core/services/localization_manager.dart';
import 'core/responsive/responsive.dart';

// global variable
bool isShowOnboarding = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiLocalizationService().init();
  await LocalizationManager().initialize();
  await configureDependencies().then((_) async {
    isShowOnboarding = await getIt<AppLocalStorage>().isShowOnboarding();
  });
  await _configureFirebase();

  Bloc.observer = AppBlocObserver();

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
              onGenerateRoute: AppRoutesGenerator.generateRoute,
              builder: (context, child) {
                final localizations = AppLocalizations.of(context);
                ApiLocalizationService().setLocalizations(localizations);
                return child!;
              },
              // routes: {'/home': (context) => const Home()},
              // home: BlocProvider(
              //   create: (context) => getIt<LoginViewModel>(),
              //   child: const LoginView(),
              home: BlocProvider(
                create: (_) => getIt<RegisterBloc>(),
                child: const RegisterView(),
              ),
              initialRoute: AppRoutes.popularTrainingScreen,
              // isShowOnboarding ? AppRoutes.loginPage : AppRoutes.onboarding,
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
