part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class FetchProfileDataEvent extends EditProfileEvent {
  const FetchProfileDataEvent();
  
  @override
  List<Object> get props => [];
}

class EditProfileDataEvent extends EditProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? weight;
  final String? goal;
  final String? activityLevel;
  
  const EditProfileDataEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.activityLevel,
  });
  
  @override
  List<Object?> get props => [firstName, lastName, email, weight, goal, activityLevel];
}
