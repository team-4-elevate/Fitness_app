// core/app_data/app_events.dart
import 'package:equatable/equatable.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class CheckUserLoginStatusEvent extends AppEvent {}


//------------------------------------------------------user login 
class UserLoggedInEvent extends AppEvent {
  final User user;
  final String? token;

  const UserLoggedInEvent({required this.user, this.token});

  @override
  List<Object?> get props => [user, token];
}


//------------------------------------------------------user logout
class UserLoggedOutEvent extends AppEvent {}


//------------------------------------------------------user profile
class SaveUserProfileEvent extends AppEvent {
  final User profileData;

  const SaveUserProfileEvent(this.profileData);

  @override
  List<Object?> get props => [profileData];
}

class ClearProfileDataEvent extends AppEvent {}


//------------------------------------------------------app locale
class ChangeAppLocaleEvent extends AppEvent {
  final String? locale;

  const ChangeAppLocaleEvent([this.locale]);

  @override
  List<Object?> get props => [locale];
}

class GetAppLocaleEvent extends AppEvent {}

//------------------------------------------------------onboarding status
class CheckOnboardingStatusEvent extends AppEvent {}
