import 'package:equatable/equatable.dart';

abstract class ProfileNavigation extends Equatable {
  // data time To let Equatable know that this is a new instance
  final DateTime timestamp;

  ProfileNavigation() : timestamp = DateTime.now();
  @override
  List<Object?> get props => [timestamp];
}

class ToEditProfile extends ProfileNavigation {
  ToEditProfile() : super();
}

class ToUpdatePassword extends ProfileNavigation {
  ToUpdatePassword() : super();
}

class ToLoginAfterLogout extends ProfileNavigation {
  ToLoginAfterLogout() : super();
}
