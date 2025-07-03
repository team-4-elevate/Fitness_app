import 'package:fitness_app/core/helper/api_result.dart';

abstract interface class ProfileRepo {
  Future<ApiResult<void>> logout();
}
