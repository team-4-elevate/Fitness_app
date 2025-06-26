// core/app_data/app_states.dart
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isLoggedIn;
  final bool hasProfileData;
  final String appLocale;
  final bool isShowOnboarding;

  const AppState({
    this.isLoggedIn = false,
    this.hasProfileData = false,
    this.appLocale = 'en',
    this.isShowOnboarding = false,
  });

  factory AppState.initial() => const AppState(hasProfileData: false);

  AppState copyWith({
    bool? isLoggedIn,
    bool? hasProfileData,
    String? appLocale,
    bool? isShowOnboarding,
  }) =>
      AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        hasProfileData: hasProfileData ?? this.hasProfileData,
        appLocale: appLocale ?? this.appLocale,
        isShowOnboarding: isShowOnboarding ?? this.isShowOnboarding,
      );

  @override
  List<Object?> get props => [
        isLoggedIn,
        hasProfileData,
        appLocale,
        isShowOnboarding,
      ];
}
