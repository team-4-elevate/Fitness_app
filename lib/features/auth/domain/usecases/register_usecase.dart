// features/auth/domain/usecases/register_usecase.dart
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/core/usecase/usecase.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase implements UseCaseModel<RegisterResponse, RegisterDetailsData> {
  final AuthRepo _authRepo;

  RegisterUseCase(this._authRepo);

  @override
  Future<ApiResult<RegisterResponse>> call(RegisterDetailsData params) async {
    return await _authRepo.register(params);
  }
}
