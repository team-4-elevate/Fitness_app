import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';

abstract class UpdatePasswordRepoInterface {
  Future<void> updatePassword(UpdatePasswordRequest request);
}
