import 'package:fitness_app/core/Constant/api_constants.dart';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_impl.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiClient])
import 'update_password_remote_ds_impl_test.mocks.dart';

void main() {
  late UpdatePasswordRemoteDsImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = UpdatePasswordRemoteDsImpl(mockApiClient);

    provideDummy<ApiResult<dynamic>>(const ApiSuccess<dynamic>(null));
    provideDummy<ApiResult<ResetPasswordResponse>>(
        ApiSuccess<ResetPasswordResponse>(
            ResetPasswordResponse(token: 'dummy-token')));
  });

  group('UpdatePasswordRemoteDsImpl', () {
    final request = UpdatePasswordRequest(
      oldPassword: 'LawRagelMater3melshApprove123!',
      newPassword: 'NewPass12&*&^*^&*&^3!',
    );
    final mockResponse = {'token': 'new-token'};

    test('should call patch on the API client with correct parameters',
        () async {
      when(mockApiClient.patch(
        ApiConstants.updatePassEndpoint,
        data: request.toJson(),
        requiresToken: true,
      )).thenAnswer((_) async => ApiSuccess<dynamic>(mockResponse));
      await dataSource.updatePassword(request);
      verify(mockApiClient.patch(
        ApiConstants.updatePassEndpoint,
        data: request.toJson(),
        requiresToken: true,
      )).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test(' return api response on success', () async {
      when(mockApiClient.patch(
        ApiConstants.updatePassEndpoint,
        data: request.toJson(),
        requiresToken: true,
      )).thenAnswer((_) async => ApiSuccess(mockResponse));

      final result = await dataSource.updatePassword(request);

      expect(result, isA<ApiSuccess<ResetPasswordResponse>>());
      final successResult = result as ApiSuccess<ResetPasswordResponse>;
      expect(successResult.data.token, equals('new-token'));
    });

    test('throw exception when apiclient returns failure', () async {
      when(mockApiClient.patch(
        ApiConstants.updatePassEndpoint,
        data: request.toJson(),
        requiresToken: true,
      )).thenAnswer((_) async => const ApiFailure('API error'));

      expect(() => dataSource.updatePassword(request),
          throwsA(equals('API error')));
      verify(mockApiClient.patch(
        ApiConstants.updatePassEndpoint,
        data: request.toJson(),
        requiresToken: true,
      )).called(1);
    });
  });
}
