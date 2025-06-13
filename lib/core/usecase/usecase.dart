import '../helper/api_result.dart';

abstract class UseCase<Type> {
  Future<ApiResult<Type>> call();
}

abstract class UseCaseModel<Type, Params> {
  Future<ApiResult<Type>> call(Params params);
}

abstract class VoidUseCase {
  Future<ApiResult<void>> call();
}

abstract class VoidUseCaseWithModel<Params> {
  Future<ApiResult<void>> call(Params params);
}
