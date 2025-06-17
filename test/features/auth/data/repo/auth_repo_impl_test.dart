import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:fitness_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasource/remote_data_source/mocks.dart';
import '../datasource/remote_data_source/mocks.mocks.dart';

void main() {
  setUpAll(() {
    setupDummyValues();
  });

  group('AuthRepoImpl Tests', () {
    late AuthRepoImpl authRepo;
    late MockAuthRemoteDataSourceContract mockAuthRemoteDataSource;
    late MockAppSecureStorage mockSecureStorage;

    setUp(() {
      mockAuthRemoteDataSource = MockAuthRemoteDataSourceContract();
      mockSecureStorage = MockAppSecureStorage();
      authRepo = AuthRepoImpl(mockAuthRemoteDataSource, mockSecureStorage);
    });

    group('login Tests', () {
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

      test(
        'should return LoginResponse and save token on successful login',
        () async {
          when(
            mockAuthRemoteDataSource.login(loginRequest),
          ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

          when(
            mockSecureStorage.saveToken(token),
          ).thenAnswer((_) async => Future.value());

          final result = await authRepo.login(loginRequest);

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
            },
            failure:
                (message) => fail('Expected success but got failure: $message'),
          );

          verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
          verify(mockSecureStorage.saveToken(token)).called(1);
        },
      );

      test('should save empty string when token is null', () async {
        final responseWithoutToken = LoginResponse(
          message: 'Login successful',
          user: mockUser,
          token: null,
        );

        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(responseWithoutToken));

        when(
          mockSecureStorage.saveToken(''),
        ).thenAnswer((_) async => Future.value());

        final result = await authRepo.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals(responseWithoutToken.message));
            expect(data.token, isNull);
            expect(data.user?.id, equals(responseWithoutToken.user?.id));
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        // Verify that empty string was saved when token is null
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockSecureStorage.saveToken('')).called(1);
      });

      test('should return ApiFailure when remote data source fails', () async {
        const errorMessage = 'Network error occurred';
        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await authRepo.login(loginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        // Verify that remote data source was called but storage was not
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verifyNever(mockSecureStorage.saveToken(any));
      });

      test('should continue with success even if token saving fails', () async {
        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        when(
          mockSecureStorage.saveToken(token),
        ).thenThrow(Exception('Storage error'));

        final result = await authRepo.login(loginRequest);

        // Should still be successful despite storage failure
        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals(mockLoginResponse.message));
            expect(data.token, equals(mockLoginResponse.token));
            expect(data.user?.id, equals(mockLoginResponse.user?.id));
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        // Verify both were called despite storage failure
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockSecureStorage.saveToken(token)).called(1);
      });

      test('should handle exception in login process', () async {
        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenThrow(Exception('Unexpected error'));

        final result = await authRepo.login(loginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, contains('Exception: Unexpected error'));
          },
        );

        // Verify that remote data source was called but storage was not
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verifyNever(mockSecureStorage.saveToken(any));
      });

      test('should pass correct login request to remote data source', () async {
        when(
          mockAuthRemoteDataSource.login(any),
        ).thenAnswer((_) async => ApiSuccess(mockLoginResponse));

        when(
          mockSecureStorage.saveToken(any),
        ).thenAnswer((_) async => Future.value());

        // Act
        await authRepo.login(loginRequest);

        // Assert - Verify the exact request was passed
        final captured =
            verify(mockAuthRemoteDataSource.login(captureAny)).captured;
        expect(captured.length, equals(1));

        final capturedRequest = captured.first as LoginRequest;
        expect(capturedRequest.email, equals(email));
        expect(capturedRequest.password, equals(password));
      });

      test('should handle malformed login response', () async {
        final malformedResponse = LoginResponse(
          message: null,
          user: null,
          token: null,
        );

        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(malformedResponse));

        when(
          mockSecureStorage.saveToken(''),
        ).thenAnswer((_) async => Future.value());

        final result = await authRepo.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, isNull);
            expect(data.token, isNull);
            expect(data.user, isNull);
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        // Verify empty string was saved for null token
        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockSecureStorage.saveToken('')).called(1);
      });

      test('should handle login with empty credentials', () async {
        final emptyLoginRequest = LoginRequest(email: '', password: '');
        const errorMessage = 'Invalid credentials';

        when(
          mockAuthRemoteDataSource.login(emptyLoginRequest),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await authRepo.login(emptyLoginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        verify(mockAuthRemoteDataSource.login(emptyLoginRequest)).called(1);
        verifyNever(mockSecureStorage.saveToken(any));
      });

      test('should handle partial user data in response', () async {
        // Arrange
        final partialUser = User(
          id: '12345',
          firstName: 'John',
          lastName: null,
          email: email,
          gender: null,
          age: null,
        );

        final partialResponse = LoginResponse(
          message: 'Login successful',
          user: partialUser,
          token: token,
        );

        when(
          mockAuthRemoteDataSource.login(loginRequest),
        ).thenAnswer((_) async => ApiSuccess(partialResponse));

        when(
          mockSecureStorage.saveToken(token),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await authRepo.login(loginRequest);

        // Assert
        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.user?.id, equals('12345'));
            expect(data.user?.firstName, equals('John'));
            expect(data.user?.lastName, isNull);
            expect(data.user?.email, equals(email));
            expect(data.user?.gender, isNull);
            expect(data.user?.age, isNull);
          },
          failure:
              (message) => fail('Expected success but got failure: $message'),
        );

        verify(mockAuthRemoteDataSource.login(loginRequest)).called(1);
        verify(mockSecureStorage.saveToken(token)).called(1);
      });
    });
  });
}
