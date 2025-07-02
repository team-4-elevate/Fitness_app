import 'package:fitness_app/core/helper/api_result.dart';

abstract interface class ProfileRemoteDs {
  Future<ApiResult<void>> logout();
}
