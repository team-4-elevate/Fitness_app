import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';

abstract class UpdatePasswordRemoteDsInterface {
  Future<void> updatePassword(UpdatePasswordRequest request);
} 