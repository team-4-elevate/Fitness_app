// features/edit_profile/presentation/bloc/edit_profile_state.dart
part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final Status fetchProfileStatus;
  final Status updateProfileStatus;
  final dynamic profileData;
  final dynamic updatedData;
  final String errorMessage;

  const EditProfileState({
    this.fetchProfileStatus = Status.initial,
    this.updateProfileStatus = Status.initial,
    this.profileData,
    this.updatedData,
    this.errorMessage = '',
  });

  EditProfileState copyWith({
    Status? fetchProfileStatus,
    Status? updateProfileStatus,
    dynamic profileData,
    dynamic updatedData,
    String? errorMessage,
  }) {
    return EditProfileState(
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      profileData: profileData ?? this.profileData,
      updatedData: updatedData ?? this.updatedData,
      errorMessage: errorMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [
        fetchProfileStatus,
        updateProfileStatus,
        profileData,
        updatedData,
        errorMessage,
      ];
}
