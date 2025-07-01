import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_response.dart';

abstract class UpdatePasswordRepoInterface {
  Future<void> updatePassword(UpdatePasswordRequest request);
}
