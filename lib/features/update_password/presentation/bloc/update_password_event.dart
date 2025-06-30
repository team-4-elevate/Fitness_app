import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object> get props => [];
}

class UpdatePasswordSubmitEvent extends UpdatePasswordEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  const UpdatePasswordSubmitEvent({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [email, oldPassword, newPassword];
}

class ToggleOldPasswordVisibilityEvent extends UpdatePasswordEvent {}

class ToggleNewPasswordVisibilityEvent extends UpdatePasswordEvent {}

class ToggleConfirmPasswordVisibilityEvent extends UpdatePasswordEvent {}

class ValidateOldPasswordEvent extends UpdatePasswordEvent {
  final String password;
  
  const ValidateOldPasswordEvent(this.password);
  
  @override
  List<Object> get props => [password];
}

class ValidateNewPasswordEvent extends UpdatePasswordEvent {
  final String password;
  
  const ValidateNewPasswordEvent(this.password);
  
  @override
  List<Object> get props => [password];
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