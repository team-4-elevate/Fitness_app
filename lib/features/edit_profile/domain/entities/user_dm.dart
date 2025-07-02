
import 'package:equatable/equatable.dart';

class UserDm extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? weight;
  final String? goal;
  final String? photo;

  const UserDm({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.weight,
    this.goal,
    this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        weight,
        goal,
        photo,
      ];

  UserDm copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    int? weight,
    String? goal,
    String? photo,
  }) {
    return UserDm(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
      photo: photo ?? this.photo,
    );
  }
}
