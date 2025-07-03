import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {}

class LogoutTappedEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ChangeLanguageTappedEvent extends ProfileEvent {
  ChangeLanguageTappedEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordTappedEvent extends ProfileEvent {
  ChangePasswordTappedEvent();
  @override
  List<Object?> get props => [];
}

class EditProfileTappedEvent extends ProfileEvent {
  EditProfileTappedEvent();
  @override
  List<Object?> get props => [];
}

class ResetNavigationEvent extends ProfileEvent {
  ResetNavigationEvent();
  @override
  List<Object?> get props => [];
}
