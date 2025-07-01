// features/edit_profile/presentation/bloc/edit_profile_state.dart
part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final Status fetchProfileStatus;
  final Status updateProfileStatus;
  final Status uploadImageStatus;
  final dynamic profileData;
  final dynamic updatedData;
  final dynamic uploadedImageData;
  final String errorMessage;
  final Map<String, String>? fieldValues;
  final String? snackbarMessage; 
  final bool isErrorSnackbar;

  const EditProfileState({
    this.fetchProfileStatus = Status.initial,
    this.updateProfileStatus = Status.initial,
    this.uploadImageStatus = Status.initial,
    this.profileData,
    this.updatedData,
    this.uploadedImageData,
    this.errorMessage = '',
    this.fieldValues,
    this.snackbarMessage,
    this.isErrorSnackbar = false,
  });

  EditProfileState copyWith({
    Status? fetchProfileStatus,
    Status? updateProfileStatus,
    Status? uploadImageStatus,
    dynamic profileData,
    dynamic updatedData,
    dynamic uploadedImageData,
    String? errorMessage,
    Map<String, String>? fieldValues,
    String? snackbarMessage,
    bool? isErrorSnackbar,
  }) {
    return EditProfileState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      uploadImageStatus: uploadImageStatus ?? this.uploadImageStatus,
      profileData: profileData ?? this.profileData,
      updatedData: updatedData ?? this.updatedData,
      uploadedImageData: uploadedImageData ?? this.uploadedImageData,
      errorMessage: errorMessage ?? '',
      fieldValues: fieldValues ?? this.fieldValues,
      snackbarMessage: snackbarMessage, 
      isErrorSnackbar: isErrorSnackbar ?? this.isErrorSnackbar,
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
        updateProfileStatus,
        uploadImageStatus,
        profileData,
        updatedData,
        uploadedImageData,
        errorMessage,
        fieldValues,
        snackbarMessage,
        isErrorSnackbar,
      ];
}
