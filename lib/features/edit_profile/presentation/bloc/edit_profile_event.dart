// features/edit_profile/presentation/bloc/edit_profile_event.dart
part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class FetchProfileDataEvent extends EditProfileEvent {
  const FetchProfileDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends EditProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? weight;
  final String? goal;
  final String? activityLevel;
  final String? fieldName;
  final String? fieldValue;

  const UpdateProfileEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.activityLevel,
    this.fieldName,
    this.fieldValue,
    this.submitToApi = false,
  });

  @override
      [firstName, lastName, email, weight, goal, activityLevel];
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        weight,
        goal,
        activityLevel,
        fieldName,
        fieldValue,
        submitToApi
      ];
}

class UploadProfileImageEvent extends EditProfileEvent {
  final File photo;

  const UploadProfileImageEvent({required this.photo});

  @override
  List<Object> get props => [photo];
}

class InitializeFormFieldsEvent extends EditProfileEvent {
  const InitializeFormFieldsEvent();

  @override
  List<Object> get props => [];
}

class UpdateControllersEvent extends EditProfileEvent {
  final Map<String, TextEditingController> controllers;

  const UpdateControllersEvent({required this.controllers});

  @override
  List<Object> get props => [controllers];
}

class ShowSnackbarEvent extends EditProfileEvent {
  final String message;
  final bool isError;

  const ShowSnackbarEvent({required this.message, required this.isError});

  @override
  List<Object> get props => [message, isError];
}
