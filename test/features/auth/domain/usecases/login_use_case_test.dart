import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:fitness_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasource/remote_data_source/mocks.dart';
import '../../data/datasource/remote_data_source/mocks.mocks.dart';

void main() {
  setUpAll(() {
    setupDummyValues();
  });

  group('LoginUseCase Tests', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepo mockAuthRepo;

    setUp(() {
      mockAuthRepo = MockAuthRepo();
      loginUseCase = LoginUseCase(mockAuthRepo);
    });

    group('call', () {
      const email = 'test@example.com';
      const password = 'password123';
      const token = 'mock_jwt_token_12345';

      final loginRequest = LoginRequest(email: email, password: password);

      final mockUser = User(
        id: '12345',
        firstName: 'John',
        lastName: 'Doe',
        email: email,
        gender: 'male',
        age: 25,
        weight: 70,
        height: 175,
        activityLevel: 'level1',
        goal: 'muscle gain',
        photo: 'https://example.com/photo.jpg',
        createdAt: DateTime.parse('2023-06-17T10:00:00.000Z'),
      );

      final mockLoginResponse = LoginResponse(
        message: 'Login successful',
        user: mockUser,
        token: token,
      );

      test('should return LoginResponse when repository call succeeds', () async {
        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        final result = await loginUseCase.call(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals(mockLoginResponse.message));
            expect(data.token, equals(mockLoginResponse.token));
            expect(data.user?.id, equals(mockLoginResponse.user?.id));
            expect(
              data.user?.firstName,
              equals(mockLoginResponse.user?.firstName),
            );
            expect(data.user?.email, equals(mockLoginResponse.user?.email));
            expect(data.user?.age, equals(mockLoginResponse.user?.age));
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        // Verify that repository was called exactly once with correct parameters
        verify(mockAuthRepo.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRepo);
      });

      test('should return ApiFailure when repository call fails', () async {
        const errorMessage = 'Network connection failed';
        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await loginUseCase.call(loginRequest);
        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
        verifyNoMoreInteractions(mockAuthRepo);
      });

      test('should pass correct LoginRequest to repository', () async {
        when(
          mockAuthRepo.login(any),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        await loginUseCase.call(loginRequest);

        //Verify the exact request was passed
        final captured = verify(mockAuthRepo.login(captureAny)).captured;
        expect(captured.length, equals(1));

        final capturedRequest = captured.first as LoginRequest;
        expect(capturedRequest.email, equals(email));
        expect(capturedRequest.password, equals(password));
      });

      test('should handle different types of errors from repository', () async {
        const authError = 'Invalid credentials';
        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiFailure(authError));

        final result = await loginUseCase.call(loginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(authError));
          },
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
      });

      test('should handle repository throwing exception', () async {
        // Arrange
        when(
          mockAuthRepo.login(loginRequest),
        ).thenThrow(Exception('Unexpected repository error'));

        // Act & Assert
        expect(
          () async => await loginUseCase.call(loginRequest),
          throwsException,
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
      });

      test('should work with empty email and password', () async {
        // Arrange
        final emptyLoginRequest = LoginRequest(email: '', password: '');
        const errorMessage = 'Email and password cannot be empty';

        when(
          mockAuthRepo.login(emptyLoginRequest),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        // Act
        final result = await loginUseCase.call(emptyLoginRequest);

        // Assert
        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        verify(mockAuthRepo.login(emptyLoginRequest)).called(1);
      });

      test('should handle response with null user', () async {
        // Arrange
        final responseWithNullUser = LoginResponse(
          message: 'Login successful',
          user: null,
          token: token,
        );

        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(responseWithNullUser));

        final result = await loginUseCase.call(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals('Login successful'));
            expect(data.token, equals(token));
            expect(data.user, isNull);
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
      });

      test('should handle response with null token', () async {
        final responseWithNullToken = LoginResponse(
          message: 'Login successful',
          user: mockUser,
          token: null,
        );

        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(responseWithNullToken));

        // Act
        final result = await loginUseCase.call(loginRequest);

        // Assert
        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals('Login successful'));
            expect(data.token, isNull);
            expect(data.user?.id, equals(mockUser.id));
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
      });

      test('should handle multiple consecutive calls', () async {
        when(
          mockAuthRepo.login(any),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        final loginRequest1 = LoginRequest(
          email: 'user1@test.com',
          password: 'pass1',
        );
        final loginRequest2 = LoginRequest(
          email: 'user2@test.com',
          password: 'pass2',
        );

        final result1 = await loginUseCase.call(loginRequest1);
        final result2 = await loginUseCase.call(loginRequest2);

        expect(result1, isA<ApiSuccess<LoginResponse>>());
        expect(result2, isA<ApiSuccess<LoginResponse>>());

        verify(mockAuthRepo.login(loginRequest1)).called(1);
        verify(mockAuthRepo.login(loginRequest2)).called(1);
      });

      test('should preserve all user data from repository response', () async {
        final complexUser = User(
          id: 'complex_user_id',
          firstName: 'Complex',
          lastName: 'User',
          email: 'complex@example.com',
          gender: 'female',
          age: 30,
          weight: 65,
          height: 170,
          activityLevel: 'level3',
          goal: 'weight loss',
          photo: 'https://example.com/complex_photo.jpg',
          createdAt: DateTime.parse('2023-01-15T08:30:00.000Z'),
        );

        final complexResponse = LoginResponse(
          message: 'Complex login successful',
          user: complexUser,
          token: 'complex_token_xyz',
        );

        when(
          mockAuthRepo.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(complexResponse));

        final result = await loginUseCase.call(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals(complexResponse.message));
            expect(data.token, equals(complexResponse.token));
            expect(data.user?.id, equals(complexUser.id));
            expect(data.user?.firstName, equals(complexUser.firstName));
            expect(data.user?.lastName, equals(complexUser.lastName));
            expect(data.user?.email, equals(complexUser.email));
            expect(data.user?.gender, equals(complexUser.gender));
            expect(data.user?.age, equals(complexUser.age));
            expect(data.user?.weight, equals(complexUser.weight));
            expect(data.user?.height, equals(complexUser.height));
            expect(data.user?.activityLevel, equals(complexUser.activityLevel));
            expect(data.user?.goal, equals(complexUser.goal));
            expect(data.user?.photo, equals(complexUser.photo));
            expect(data.user?.createdAt, equals(complexUser.createdAt));
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        verify(mockAuthRepo.login(loginRequest)).called(1);
      });
    });
  });
}
