import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final ProfileRepo _profileRepo;

  LogoutUseCase(this._profileRepo);

  Future<ApiResult<void>> call() async {
    final result = await _profileRepo.logout();
    return result;
  }
}
