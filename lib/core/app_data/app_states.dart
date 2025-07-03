// core/app_data/app_states.dart
import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';

class AppState extends Equatable {
  final bool isLoggedIn;
  final bool hasProfileData;
  final String appLocale;
  final bool isShowOnboarding;
  final User? cachedUserData;

  const AppState({
    this.isLoggedIn = false,
    this.hasProfileData = false,
    this.appLocale = 'en',
    this.isShowOnboarding = false,
    this.cachedUserData,
  });

  factory AppState.initial() => const AppState(hasProfileData: false);

  AppState copyWith({
    bool? isLoggedIn,
    bool? hasProfileData,
    String? appLocale,
    bool? isShowOnboarding,
    User? cachedUserData,
  }) =>
      AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        hasProfileData: hasProfileData ?? this.hasProfileData,
        appLocale: appLocale ?? this.appLocale,
        isShowOnboarding: isShowOnboarding ?? this.isShowOnboarding,
        cachedUserData: cachedUserData ?? this.cachedUserData,
      );

  @override
  List<Object?> get props => [
        isLoggedIn,
        hasProfileData,
        appLocale,
        isShowOnboarding,
        cachedUserData,
      ];
}
