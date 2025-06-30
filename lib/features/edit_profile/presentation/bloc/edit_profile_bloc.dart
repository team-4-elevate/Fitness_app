// features/edit_profile/presentation/bloc/edit_profile_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final EditProfileDataUseCase _editProfileDataUseCase;

  Timer? _autoSaveDebouncer;

  EditProfileBloc(
    this._getProfileDataUseCase,
    this._editProfileDataUseCase,
  ) : super(const EditProfileState()) {
    _mapEvents();
  }

  bool hasProfileDataChanged({
    required String firstName,
    required String lastName,
    required String email,
    required String weight,
    required String goal,
    required String activityLevel,
  }) {
    if (state.profileData?.user == null) return false;
    final user = state.profileData!.user!;

    return firstName != user.firstName ||
        lastName != user.lastName ||
        email != user.email ||
        weight != (user.weight?.toString() ?? "") ||
        goal != user.goal ||
        activityLevel != user.activityLevel;
  }

  void debouncedSaveProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String weight,
    required String goal,
    required String activityLevel,
  }) {
    _autoSaveDebouncer?.cancel();

    if (hasProfileDataChanged(
      firstName: firstName,
      lastName: lastName,
      email: email,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel,
    )) {
      _autoSaveDebouncer = Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          add(EditProfileDataEvent(
            firstName: firstName,
            lastName: lastName,
            email: email,
            weight: weight,
            goal: goal,
            activityLevel: activityLevel,
          ));
        }
      });
    }
  }

  @override
  Future<void> close() {
    _autoSaveDebouncer?.cancel();
    return super.close();
  }

  Future<void> _onFetchProfileData(
      FetchProfileDataEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(
      fetchProfileStatus: Status.loading,
      errorMessage: '',
    ));

    try {
      final result = await _getProfileDataUseCase();

      result.when(
        success: (data) => emit(state.copyWith(
          fetchProfileStatus: Status.success,
          profileData: data,
        )),
        failure: (error) => emit(state.copyWith(
          fetchProfileStatus: Status.error,
          errorMessage: error.toString(),
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        fetchProfileStatus: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onEditProfileData(
      EditProfileDataEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(
      updateProfileStatus: Status.loading,
      errorMessage: '',
    ));

    try {
      final result = await _editProfileDataUseCase(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        weight: event.weight,
        goal: event.goal,
        activityLevel: event.activityLevel,
      );

      result.when(
        success: (data) => emit(state.copyWith(
          updateProfileStatus: Status.success,
          updatedData: data,
          profileData: data,
        )),
        failure: (error) => emit(state.copyWith(
          updateProfileStatus: Status.error,
          errorMessage: error.toString(),
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        updateProfileStatus: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _mapEvents() {
    on<FetchProfileDataEvent>(_onFetchProfileData);
    on<EditProfileDataEvent>(_onEditProfileData);
  }
}
