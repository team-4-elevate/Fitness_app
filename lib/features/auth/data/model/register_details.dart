// features/auth/data/mapper/register_details.dart
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:fitness_app/features/auth/data/model/register/register_request.dart';

class RegisterDetailsData {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  Gender? gender;
  int? age;
  int? weight;
  int? height;
  String? goal;
  String? activityLevel;

  RegisterDetailsData({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
    this.activityLevel,
  });

  RegisterRequest toRegisterRequest() {
    return RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender?.name,
      height: height,
      weight: weight,
      age: age,
      goal: goal,
      activityLevel: activityLevel,
    );
  }
}
