import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_impl.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_request/login_request.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/login_response.dart';
import 'package:fitness_app/features/auth/data/model/login_models/login_response/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../food_recommendation/data/datasources/food_recommend_remote_data_source_impl_test.mocks.dart';
import 'mocks.dart';

void main() {
  // Setup dummy values before running tests
  setUpAll(() {
    setupDummyValues();
  });

  group('AuthRemoteDataSourceImpl Tests', () {
    late AuthRemoteDataSourceImpl authRemoteDataSource;
    late MockApiClient mockApiClient;

    setUp(() {
      mockApiClient = MockApiClient();
      authRemoteDataSource = AuthRemoteDataSourceImpl(mockApiClient);
    });

    group('login', () {
      const email = 'test@example.com';
      const password = 'password123';

      final loginRequest = LoginRequest(email: email, password: password);

      final mockApiResponse = {
        'message': 'success',
        'user': {
          '_id': '12345',
          'firstName': 'John',
          'lastName': 'Doe',
          'email': 'test@example.com',
          'gender': 'male',
          'age': 25,
          'weight': 70,
          'height': 175,
          'activityLevel': 'level1',
          'goal': 'muscle gain',
          'photo': 'https://example.com/photo.jpg',
        },
        'token': 'mock_jwt_token_12345',
      };

      final expectedLoginResponse = LoginResponse(
        message: 'success',
        user: User(
          id: '12345',
          firstName: 'John',
          lastName: 'Doe',
          email: 'test@example.com',
          gender: 'male',
          age: 25,
          weight: 70,
          height: 175,
          activityLevel: 'level1',
          goal: 'muscle gain',
          photo: 'https://example.com/photo.jpg',
          // createdAt: '2023-06-17T10:00:00.000Z',
        ),
        token: 'mock_jwt_token_12345',
      );

      test('should return LoginResponse on successful login', () async {
        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockApiResponse));

        // Act
        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals(expectedLoginResponse.message));
            expect(data.token, equals(expectedLoginResponse.token));
            expect(data.user?.id, equals(expectedLoginResponse.user?.id));
            expect(
              data.user?.firstName,
              equals(expectedLoginResponse.user?.firstName),
            );
            expect(data.user?.email, equals(expectedLoginResponse.user?.email));
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );

        verify(
          mockApiClient.post(
            ApiConstants.loginEndpoint,
            data: loginRequest.toJson(),
          ),
        ).called(1);
      });

      test('should return ApiFailure when API call fails', () async {
        const errorMessage = 'Network error occurred';
        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );

        verify(
          mockApiClient.post(
            ApiConstants.loginEndpoint,
            data: loginRequest.toJson(),
          ),
        ).called(1);
      });

      test('should handle invalid email format', () async {
        // Arrange
        final invalidLoginRequest = LoginRequest(
          email: 'invalid-email',
          password: password,
        );

        const errorMessage = 'Invalid email format';
        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await authRemoteDataSource.login(invalidLoginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );
      });

      test('should handle empty credentials', () async {
        final emptyLoginRequest = LoginRequest(email: '', password: '');

        const errorMessage = 'Email and password are required';
        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiFailure(errorMessage));

        final result = await authRemoteDataSource.login(emptyLoginRequest);

        expect(result, isA<ApiFailure<LoginResponse>>());

        result.when(
          success: (data) => fail('Expected failure but got success'),
          failure: (message) {
            expect(message, equals(errorMessage));
          },
        );
      });

      test('should handle malformed response data with empty fields', () async {
        final malformedResponse = {
          'invalid_structure': true,
          'missing_required_fields': 'test',
        };

        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(malformedResponse));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, isNull);
            expect(data.token, isNull);
            expect(data.user, isNull);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );
      });

      test('should handle response with invalid data types', () async {
        final responseWithInvalidTypes = {
          'message': '123',
          'token': 'invalid_token_string',
          'user': null,
        };

        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(responseWithInvalidTypes));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data, isA<LoginResponse>());
            expect(data.message, equals('123'));
            expect(data.token, equals('invalid_token_string'));
            expect(data.user, isNull);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );
      });

      test('should call API with correct endpoint and data', () async {
        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(mockApiResponse));

        await authRemoteDataSource.login(loginRequest);

        verify(
          mockApiClient.post(
            ApiConstants.loginEndpoint,
            data: {'email': email, 'password': password},
          ),
        ).called(1);

        verifyNoMoreInteractions(mockApiClient);
      });

      test('should handle null user in response', () async {
        final responseWithNullUser = {
          'message': 'success',
          'user': null,
          'token': 'mock_jwt_token_12345',
        };

        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(responseWithNullUser));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals('success'));
            expect(data.token, equals('mock_jwt_token_12345'));
            expect(data.user, isNull);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );
      });

      test('should handle missing token in response', () async {
        final responseWithoutToken = {
          'message': 'success',
          'user': mockApiResponse['user'],
        };

        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(responseWithoutToken));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, equals('success'));
            expect(data.token, isNull);
            expect(data.user, isNotNull);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );
      });

      test('should handle empty response', () async {
        final emptyResponse = <String, dynamic>{};

        when(
          mockApiClient.post(
            any,
            data: anyNamed('data'),
            queryParameters: anyNamed('queryParameters'),
            requiresToken: anyNamed('requiresToken'),
          ),
        ).thenAnswer((_) async => ApiSuccess(emptyResponse));

        final result = await authRemoteDataSource.login(loginRequest);

        expect(result, isA<ApiSuccess<LoginResponse>>());

        result.when(
          success: (data) {
            expect(data.message, isNull);
            expect(data.token, isNull);
            expect(data.user, isNull);
          },
          failure: (message) =>
              fail('Expected success but got failure: $message'),
        );
      });
    });
  });
}
