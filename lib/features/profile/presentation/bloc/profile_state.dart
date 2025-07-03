part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.logoutState, this.languageChangedState, this.navigationState});
  final AppStates<void>? logoutState;
  final AppStates<void>? languageChangedState;
  final ProfileNavigation? navigationState;

  ProfileState copyWith({
    AppStates<void>? logoutState,
    AppStates<void>? languageChangedState,
    ProfileNavigation? navigationState,
  }) {
    return ProfileState(
      logoutState: logoutState ?? this.logoutState,
      languageChangedState: languageChangedState ?? this.languageChangedState,
      navigationState: navigationState ?? this.navigationState,
    );
  }

  @override
  List<Object?> get props => [
        logoutState,
        languageChangedState,
        navigationState,
      ];
}
