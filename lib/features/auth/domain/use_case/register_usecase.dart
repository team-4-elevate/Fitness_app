// features/auth/domain/use_case/register_usecase.dart
import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';

@injectable
class RegisterUsecase {
  final AuthRepo _authRepo;

  RegisterUsecase(this._authRepo);

}