import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:fitness_app/features/auth/domain/repo/auth_repo.dart';
import 'package:fitness_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  AuthRemoteDataSourceContract,
  AppSecureStorage,
  AuthRepo,
  LoginUseCase,
])
void main() {}

// Dummy values for Mockito
void setupDummyValues() {
  provideDummy<ApiResult<Map<String, dynamic>>>(ApiFailure('Dummy failure'));

  provideDummy<ApiResult<dynamic>>(ApiFailure('Dummy failure'));

  provideDummy<Map<String, dynamic>>(<String, dynamic>{});

  provideDummy<ApiResult<LoginResponse>>(
    ApiFailure<LoginResponse>('Dummy login failure'),
  );

  provideDummy<LoginResponse>(
    LoginResponse(message: 'Dummy message', user: null, token: 'dummy_token'),
  );

  provideDummy<User>(
    User(
      id: 'dummy_id',
      firstName: 'Dummy',
      lastName: 'User',
      email: 'dummy@example.com',
    ),
  );

  provideDummy<LoginRequest>(
    LoginRequest(email: 'dummy@example.com', password: 'dummyPassword'),
  );

  provideDummy<AppStates<LoginResponse>>(InitialState<LoginResponse>());

  provideDummy<LoadingState<LoginResponse>>(LoadingState<LoginResponse>());

  provideDummy<SuccessState<LoginResponse>>(
    SuccessState<LoginResponse>(
      LoginResponse(message: 'Dummy success', user: null, token: 'dummy_token'),
    ),
  );

  provideDummy<ErrorState<LoginResponse>>(
    ErrorState<LoginResponse>('Dummy error'),
  );

  provideDummy<Future<void>>(Future.value());

  provideDummy<DateTime>(DateTime.parse('2023-01-01T00:00:00.000Z'));
}
