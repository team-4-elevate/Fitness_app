// features/edit_profile/presentation/bloc/edit_profile_bloc.dart
import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/Constant/app_keys.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/features/edit_profile/domain/entities/activity_level_constants.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/user.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:fitness_app/features/edit_profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final GetProfileDataUseCase _getProfileDataUseCase;
  final EditProfileDataUseCase _editProfileDataUseCase;
  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  final AppSecureStorage _securestorage;

  Timer? _autoSaveDebouncer;

  EditProfileBloc({
    required GetProfileDataUseCase getProfileDataUseCase,
    required EditProfileDataUseCase editProfileDataUseCase,
    required UploadProfileImageUseCase uploadProfileImageUseCase,
    required AppSecureStorage securestorage,
  })  : _getProfileDataUseCase = getProfileDataUseCase,
        _editProfileDataUseCase = editProfileDataUseCase,
        _uploadProfileImageUseCase = uploadProfileImageUseCase,
        _securestorage = securestorage,
        super(const EditProfileState()) {
    on<FetchProfileDataEvent>(_onFetchProfileData);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<UploadProfileImageEvent>(_onUploadProfileImage);
    on<InitializeFormFieldsEvent>(_onInitializeFormFields);
    on<UpdateControllersEvent>(_onUpdateControllers);
    on<ShowSnackbarEvent>(_onShowSnackbar);
  }

  bool _hasProfileDataChanged({
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

  void _debouncedSaveProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String weight,
    required String goal,
    required String activityLevel,
  }) {
    _autoSaveDebouncer?.cancel();

    if (_hasProfileDataChanged(
      firstName: firstName,
      lastName: lastName,
      email: email,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel,
    )) {
      _autoSaveDebouncer = Timer(const Duration(seconds: 2), () {
        if (!isClosed) {
          add(UpdateProfileEvent(
            firstName: firstName,
            lastName: lastName,
            email: email,
            weight: weight,
            goal: goal,
            activityLevel: activityLevel,
            submitToApi: true,
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
        success: (data) async {
          emit(state.copyWith(
            fetchProfileStatus: Status.success,
            profileData: data,
          ));
          if (data.user != null) {
            await _securestorage.saveUserData(
                'firstName', data.user!.firstName ?? '');
            if (data.user!.photo != null && data.user!.photo!.isNotEmpty) {
              await _securestorage.saveUserData('photo', data.user!.photo!);
            }
          }

          add(const InitializeFormFieldsEvent());
        },
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

  Future<void> _onUpdateProfile(
      UpdateProfileEvent event, Emitter<EditProfileState> emit) async {
    if (event.fieldName != null &&
        event.fieldValue != null &&
        !event.submitToApi) {
      final currentValues = state.fieldValues ?? {};
      final updatedValues = Map<String, String>.from(currentValues);
      updatedValues[event.fieldName!] = event.fieldValue!;

      emit(state.copyWith(fieldValues: updatedValues));

      if (updatedValues.containsKey(AppKeys.firstName) &&
          updatedValues.containsKey(AppKeys.lastName) &&
          updatedValues.containsKey(AppKeys.email) &&
          updatedValues.containsKey(AppKeys.weight) &&
          updatedValues.containsKey(AppKeys.goal) &&
          updatedValues.containsKey(AppKeys.activityLevel) &&
          updatedValues[AppKeys.firstName]!.isNotEmpty &&
          updatedValues[AppKeys.lastName]!.isNotEmpty &&
          updatedValues[AppKeys.email]!.isNotEmpty &&
          updatedValues[AppKeys.weight]!.isNotEmpty &&
          updatedValues[AppKeys.goal]!.isNotEmpty &&
          updatedValues[AppKeys.activityLevel]!.isNotEmpty) {
        _triggerDebouncedSaveWithFieldValues(updatedValues);
      }
      return;
    }

    if (event.submitToApi) {
      final firstName = event.firstName;
      final lastName = event.lastName;
      final email = event.email;
      final weight = event.weight;
      final goal = event.goal;
      final activityLevel = event.activityLevel;

      if (firstName == null ||
          lastName == null ||
          email == null ||
          weight == null ||
          goal == null ||
          activityLevel == null ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          weight.isEmpty ||
          goal.isEmpty ||
          activityLevel.isEmpty) {
        emit(state.copyWith(
          updateProfileStatus: Status.error,
          errorMessage: 'Please fill in all required fields',
          snackbarMessage: 'Please fill in all required fields',
          isErrorSnackbar: true,
        ));
        return;
      }
    }

    final currentProfileData = state.profileData;
    if (currentProfileData != null && currentProfileData.user != null) {
      final currentUser = currentProfileData.user!;

      final updatedUser = User(
        id: currentUser.id,
        firstName: event.firstName ?? currentUser.firstName,
        lastName: event.lastName ?? currentUser.lastName,
        email: event.email ?? currentUser.email,
        weight: event.weight != null
            ? int.tryParse(event.weight!)
            : currentUser.weight,
        height: currentUser.height,
        gender: currentUser.gender,
        age: currentUser.age,
        activityLevel: event.activityLevel ?? currentUser.activityLevel,
        goal: event.goal ?? currentUser.goal,
        photo: currentUser.photo,
        createdAt: currentUser.createdAt,
      );

      EditProfileResponse updatedProfileData;
      if (currentProfileData is EditProfileResponse) {
        updatedProfileData = EditProfileResponse(
            user: updatedUser, message: currentProfileData.message);
      } else {
        updatedProfileData = currentProfileData;
      }

      emit(state.copyWith(
        updateProfileStatus: Status.loading,
        errorMessage: '',
        profileData: updatedProfileData,
        updatedData: updatedProfileData,
      ));

      try {
        final result = await _editProfileDataUseCase(
          firstName: event.firstName ?? currentUser.firstName,
          lastName: event.lastName ?? currentUser.lastName,
          email: event.email ?? currentUser.email,
          weight: event.weight ?? currentUser.weight?.toString(),
          goal: event.goal ?? currentUser.goal,
          activityLevel: event.activityLevel ?? currentUser.activityLevel,
        );

        result.when(success: (data) async {
          // Save user data to local storage when profile is updated
          if (data.user != null) {
            // If first name was updated, save it to local storage
            if (event.fieldName == AppKeys.firstName ||
                event.firstName != null) {
              await _securestorage.saveUserData(
                  'firstName', data.user!.firstName ?? '');
            }
            // If photo is available, save it too
            if (data.user!.photo != null && data.user!.photo!.isNotEmpty) {
              await _securestorage.saveUserData('photo', data.user!.photo!);
            }
          }

          emit(state.copyWith(
            updateProfileStatus: Status.success,
            errorMessage: '',
            profileData: data,
            updatedData: data,
            snackbarMessage: 'Profile updated successfully!',
            isErrorSnackbar: false,
          ));
        }, failure: (error) {
          emit(state.copyWith(
            updateProfileStatus: Status.error,
            errorMessage: error.toString(),
            profileData: currentProfileData,
            snackbarMessage: 'Error updating profile: ${error.toString()}',
            isErrorSnackbar: true,
          ));
        });
      } catch (e) {
        emit(state.copyWith(
          updateProfileStatus: Status.error,
          errorMessage: e.toString(),
          profileData: currentProfileData,
          snackbarMessage: 'Error updating profile: ${e.toString()}',
          isErrorSnackbar: true,
        ));
      }
    } else {
      emit(state.copyWith(
        updateProfileStatus: Status.error,
        errorMessage: 'No profile data available',
        snackbarMessage: 'No profile data available',
        isErrorSnackbar: true,
      ));
    }
  }

  Future<void> _onUploadProfileImage(
      UploadProfileImageEvent event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(
      uploadImageStatus: Status.loading,
      errorMessage: '',
    ));

    try {
      final result = await _uploadProfileImageUseCase(event.photo);

      result.when(
        success: (data) {
          emit(state.copyWith(
            uploadImageStatus: Status.success,
            uploadedImageData: data,
            snackbarMessage: 'Profile image uploaded successfully!',
            isErrorSnackbar: false,
          ));

          // We need to fetch updated profile data to get the new photo URL
          // The photo URL will be saved in the _onFetchProfileData method
          add(const FetchProfileDataEvent());
        },
        failure: (error) => emit(state.copyWith(
          uploadImageStatus: Status.error,
          errorMessage: error.toString(),
          snackbarMessage: 'Error uploading image: ${error.toString()}',
          isErrorSnackbar: true,
        )),
      );
    } catch (e) {
      emit(state.copyWith(
        uploadImageStatus: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _triggerDebouncedSaveWithFieldValues(Map<String, String> fieldValues) {
    final firstName = fieldValues[AppKeys.firstName] ??
        state.profileData?.user?.firstName ??
        '';
    final lastName = fieldValues[AppKeys.lastName] ??
        state.profileData?.user?.lastName ??
        '';
    final email =
        fieldValues[AppKeys.email] ?? state.profileData?.user?.email ?? '';
    final weight = fieldValues[AppKeys.weight] ??
        (state.profileData?.user?.weight?.toString() ?? '');
    final goal =
        fieldValues[AppKeys.goal] ?? state.profileData?.user?.goal ?? '';
    final activityLevel = fieldValues[AppKeys.activityLevel] ??
        state.profileData?.user?.activityLevel ??
        '';

    if (goal.isEmpty || activityLevel.isEmpty || weight.isEmpty) {
      return;
    }

    if (!ActivityLevelConstants.validLevels.contains(activityLevel)) {
      return;
    }
    _debouncedSaveProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      weight: weight,
      goal: goal,
      activityLevel: activityLevel,
    );
  }

  void _onInitializeFormFields(
      InitializeFormFieldsEvent event, Emitter<EditProfileState> emit) {
    if (state.profileData?.user != null) {
      final user = state.profileData!.user!;

      final initialFieldValues = <String, String>{
        AppKeys.firstName: user.firstName ?? '',
        AppKeys.lastName: user.lastName ?? '',
        AppKeys.email: user.email ?? '',
        AppKeys.weight: user.weight?.toString() ?? '',
        AppKeys.goal: user.goal ?? '',
        AppKeys.activityLevel: user.activityLevel ?? '',
      };

      emit(state.copyWith(fieldValues: initialFieldValues));
    }
  }

  void _onUpdateControllers(
      UpdateControllersEvent event, Emitter<EditProfileState> emit) {
    if (state.profileData != null) {
      final user = state.profileData?.user;
      if (user != null) {
        event.controllers[AppKeys.firstName]?.text = user.firstName ?? '';
        event.controllers[AppKeys.lastName]?.text = user.lastName ?? '';
        event.controllers[AppKeys.email]?.text = user.email ?? '';
        event.controllers[AppKeys.weight]?.text = user.weight?.toString() ?? '';
        event.controllers[AppKeys.goal]?.text = user.goal ?? '';
        event.controllers[AppKeys.activityLevel]?.text =
            user.activityLevel ?? '';
      }
    }
  }

  void _onShowSnackbar(
      ShowSnackbarEvent event, Emitter<EditProfileState> emit) {}
}
