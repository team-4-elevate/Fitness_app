// test/features/auth/presentation/register/bloc/register_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/features/auth/presentation/register/pages/register_details_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fitness_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:fitness_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:fitness_app/features/auth/domain/entities/register_details.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/user.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/core/helper/api_result.dart';

import 'register_bloc_test.mocks.dart';

@GenerateMocks([RegisterUseCase])

// Provide dummy value for ApiResult<RegisterResponse> to help Mockito
RegisterResponse dummyResponse = RegisterResponse(
  message: 'Dummy response',
  token: 'dummy_token',
  user: User(),
);

void main() {
  // Setup dummy values for mockito
  provideDummy<ApiResult<RegisterResponse>>(ApiSuccess<RegisterResponse>(dummyResponse));

  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registerBloc = RegisterBloc(mockRegisterUseCase);
  });

  tearDown(() {
    registerBloc.close();
  });

  test('initial state should be InitialState', () {
    expect(registerBloc.state, isA<InitialState>());
  });

  group('RegisterSubmitted', () {
    final userData = RegisterDetailsData(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      password: 'Password123!',
      gender: Gender.male,
      age: 30,
      weight: 80,
      height: 180,
      goal: 'get_fitter',
      activityLevel: 'level3',
    );

    //------------------------------- Bloc Tests --------------------------------
    blocTest<RegisterBloc, RegisterStateType>(
      'should emit LoadingState, SuccessState when registration is successful',
      build: () {
        final successResponse = RegisterResponse(
          message: 'Registration successful',
          token: 'test_token_12345',
          user: null, 
        );
        when(mockRegisterUseCase(any))
            .thenAnswer((_) async => ApiSuccess(successResponse));
        return registerBloc;
      },
      act: (bloc) => bloc.add(RegisterSubmitted(userData)),
      expect: () => [
        isA<LoadingState>(),
        isA<SuccessState>(),
      ],
    );

    blocTest<RegisterBloc, RegisterStateType>(
      'should emit LoadingState, ErrorState when registration fails',
      build: () {
        when(mockRegisterUseCase(any))
            .thenAnswer((_) async => ApiFailure('Registration failed'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(RegisterSubmitted(userData)),
      expect: () => [
        isA<LoadingState>(),
        isA<ErrorState>(),
      ],
    );
  });
}
