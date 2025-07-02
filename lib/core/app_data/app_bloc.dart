// core/app_data/app_bloc.dart
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/app_data/app_events.dart';
import 'package:fitness_app/core/app_data/app_states.dart';
import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';

@lazySingleton
class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthLocalDataSourceContract _authLocalDataSource;
  final AppSecureStorage _appSecureStorage;

  User? _cachedUserProfileData;
  DateTime? _lastProfileFetchTime;

  AppBloc(this._authLocalDataSource, this._appSecureStorage)
      : super(const AppState()) {
    on<CheckUserLoginStatusEvent>(_onCheckUserLoginStatus);
    on<UserLoggedInEvent>(_onUserLoggedIn);
    on<UserLoggedOutEvent>(_onUserLoggedOut);
    // on<SaveUserProfileEvent>(_onSaveUserProfile);
    // on<ClearProfileDataEvent>(_onClearProfileData);
    // on<GetAppLocaleEvent>(_onGetAppLocale);
    // on<ChangeAppLocaleEvent>(_onChangeAppLocale);
    on<CheckOnboardingStatusEvent>(_onCheckOnboardingStatus);
    on<CacheUserDataEvent>(_onCacheUserDataEvent);
    on<GetCachedUserDataEvent>(_onGetCachedUserDataEvent);
  }

  User? get cachedUserProfileData => _cachedUserProfileData;

  bool hasProfileData() => _cachedUserProfileData != null;

  bool isProfileDataFresh() {
    if (_lastProfileFetchTime == null) return false;
    return DateTime.now().difference(_lastProfileFetchTime!).inMinutes < 30;
  }

  Future<void> _onCheckUserLoginStatus(
    CheckUserLoginStatusEvent event,
    Emitter<AppState> emit,
  ) async {
    final token = await _authLocalDataSource.getToken();
    final rememberMe = await _authLocalDataSource.getRememberMe();
    final isLoggedIn = rememberMe && token != null && token.isNotEmpty;
    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }

  Future<void> _onUserLoggedIn(
    UserLoggedInEvent event,
    Emitter<AppState> emit,
  ) async {
    _cachedUserProfileData = event.user;
    _lastProfileFetchTime = DateTime.now();

    if (event.token?.isNotEmpty ?? false) {
      await _authLocalDataSource.cacheToken(event.token!);
    }

    await _authLocalDataSource.cacheRememberMe(true);

    emit(state.copyWith(isLoggedIn: true, hasProfileData: true));
  }

  Future<void> _onUserLoggedOut(
    UserLoggedOutEvent event,
    Emitter<AppState> emit,
  ) async {
    _cachedUserProfileData = null;
    _lastProfileFetchTime = null;

    await _authLocalDataSource.deleteToken();
    await _authLocalDataSource.deleteRememberMe();

    emit(state.copyWith(isLoggedIn: false, hasProfileData: false));
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatusEvent event,
    Emitter<AppState> emit,
  ) async {
    final appLocalStorage = getIt<AppLocalStorage>();
    final hasCompletedOnboarding = await appLocalStorage.isShowOnboarding();
    emit(state.copyWith(isShowOnboarding: hasCompletedOnboarding));
  }

  Future<void> _onCacheUserDataEvent(
    CacheUserDataEvent event,
    Emitter<AppState> emit,
  ) async {
    await _appSecureStorage.saveUserData(
        AppKeys.userData, jsonEncode(event.userInfo.toJson()));
    emit(state.copyWith(
      cachedUserData: event.userInfo,
    ));
  }

  Future<void> _onGetCachedUserDataEvent(
    GetCachedUserDataEvent event,
    Emitter<AppState> emit,
  ) async {
    final userData = await _appSecureStorage.getUserData(AppKeys.userData);
    if (userData != null) {
      final userInfo = User.fromJson(jsonDecode(userData));
      emit(state.copyWith(cachedUserData: userInfo));
    }
  }
}
