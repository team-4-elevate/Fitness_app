import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';

class UpdatePasswordState extends Equatable {
  final Status updatePasswordStatus;
  final String userEmail;
  final String errorMessage;
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool arePasswordsMatching;
  final String? oldPasswordError;
  final String? newPasswordError;
  final String? confirmPasswordError;

  const UpdatePasswordState({
    this.updatePasswordStatus = Status.initial,
    this.userEmail = '',
    this.errorMessage = '',
    this.isOldPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.arePasswordsMatching = true,
    this.oldPasswordError,
    this.newPasswordError,
    this.confirmPasswordError,
  });

  UpdatePasswordState copyWith({
    Status? updatePasswordStatus,
    String? errorMessage,
    String? userEmail,
    bool? isOldPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? arePasswordsMatching,
    String? oldPasswordError,
    String? newPasswordError,
    String? confirmPasswordError,
  }) {
    return UpdatePasswordState(
      userEmail: userEmail ?? this.userEmail,
      errorMessage: errorMessage ?? '',
      updatePasswordStatus: updatePasswordStatus ?? this.updatePasswordStatus,
      isOldPasswordVisible: isOldPasswordVisible ?? this.isOldPasswordVisible,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      arePasswordsMatching: arePasswordsMatching ?? this.arePasswordsMatching,
      oldPasswordError: oldPasswordError,
      newPasswordError: newPasswordError,
      confirmPasswordError: confirmPasswordError,
    );
  }

  @override
  List get props => [
        userEmail,
        errorMessage,
        updatePasswordStatus,
        isOldPasswordVisible,
        isNewPasswordVisible,
        isConfirmPasswordVisible,
        arePasswordsMatching,
        oldPasswordError,
        newPasswordError,
        confirmPasswordError,
      ];
} 