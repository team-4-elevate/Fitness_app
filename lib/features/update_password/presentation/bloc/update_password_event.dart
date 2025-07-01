import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/update_password/domain/enums/update_password_ui_fields.dart';
import 'package:flutter/material.dart';

sealed class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdatePasswordSubmitEvent extends UpdatePasswordEvent {
  final String oldPassword;
  final String newPassword;

  const UpdatePasswordSubmitEvent({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class TogglePassVisibilityEvent extends UpdatePasswordEvent {
  final UpdatePassUiType type;
  const TogglePassVisibilityEvent({
    required this.type,
  });
}

class ValidateConfirmPasswordEvent extends UpdatePasswordEvent {
  final String confirmPassword;
  final String newPassword;

  const ValidateConfirmPasswordEvent({
    required this.confirmPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [confirmPassword, newPassword];
}
