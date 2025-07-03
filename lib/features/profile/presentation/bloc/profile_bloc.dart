import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/services/localization_manager.dart';
import 'package:fitness_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_navigation.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LogoutUseCase _logoutUseCase;
  final LocalizationManager _localizationManage;
  ProfileBloc(
    this._logoutUseCase,
    this._localizationManage,
  ) : super(ProfileState()) {
    on<ProfileEvent>((event, emit) {});
    on<LogoutTappedEvent>(_onLogoutTapped);
    on<ChangeLanguageTappedEvent>(_onChangeLanguageTapped);
    on<EditProfileTappedEvent>(_onEditProfileTapped);
    on<ChangePasswordTappedEvent>(_onChangePasswordTapped);
    on<ResetNavigationEvent>(_resetNavigationEvent);
  }

  Future<void> _onLogoutTapped(
    LogoutTappedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(logoutState: const LoadingState()));
    try {
      final result = await _logoutUseCase();
      result.when(
        success: (_) {
          emit(state.copyWith(
            logoutState: const SuccessState(),
            navigationState: ToLoginAfterLogout(),
          ));
        },
        failure: (error) {
          emit(state.copyWith(logoutState: ErrorState(error)));
        },
      );
    } catch (e) {
      emit(state.copyWith(logoutState: ErrorState(e.toString())));
    }
  }

  Future<void> _onChangeLanguageTapped(
    ChangeLanguageTappedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _localizationManage.toggleLanguage();
      emit(state.copyWith(languageChangedState: const SuccessState()));
    } catch (e) {
      emit(state.copyWith(languageChangedState: ErrorState(e.toString())));
    }
  }

  Future<void> _onEditProfileTapped(
    EditProfileTappedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(navigationState: ToEditProfile()));
  }

  Future<void> _onChangePasswordTapped(
    ChangePasswordTappedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(navigationState: ToUpdatePassword()));
  }

  void _resetNavigationEvent(
    ResetNavigationEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(navigationState: null));
  }
}
