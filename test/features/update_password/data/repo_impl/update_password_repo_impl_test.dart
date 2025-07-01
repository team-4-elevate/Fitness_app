import 'package:fitness_app/core/Constant/app_constants.dart';
import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:fitness_app/features/update_password/data/data_sources/update_password_remote_ds_interface.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/data/repo_impl/update_password_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UpdatePasswordRemoteDsInterface, AuthLocalDataSourceContract])
import 'update_password_repo_impl_test.mocks.dart';

void main() {
  late UpdatePasswordRepoImpl repo;
  late MockUpdatePasswordRemoteDsInterface mockRemoteDs;
  late MockAuthLocalDataSourceContract mockLocalDs;

  setUp(() {
    mockRemoteDs = MockUpdatePasswordRemoteDsInterface();
    mockLocalDs = MockAuthLocalDataSourceContract();
    repo = UpdatePasswordRepoImpl(mockRemoteDs, mockLocalDs);

    provideDummy<ApiResult<ResetPasswordResponse>>(
        ApiSuccess<ResetPasswordResponse>(
            ResetPasswordResponse(token: 'dummy-token')));
  });

  group('updatePasswordRepoImpl', () {
    final request = UpdatePasswordRequest(
      oldPassword: 'OldPass@@@@@@@@@@@@@@@@@@@@@@@@@123',
      newPassword: 'NewPass@@@@@@123!',
    );
    final successResponse = ResetPasswordResponse(token: 'new-token');

    test(
        'should call updatePassword on the remote data source and cache token on success',
        () async {
      when(mockRemoteDs.updatePassword(request)).thenAnswer(
          (_) async => ApiSuccess<ResetPasswordResponse>(successResponse));
      when(mockLocalDs.cacheToken(any)).thenAnswer((_) async {});
      await repo.updatePassword(request);
      verify(mockRemoteDs.updatePassword(request)).called(1);
      verify(mockLocalDs.cacheToken('new-token')).called(1);
      verifyNoMoreInteractions(mockRemoteDs);
    });
  });
}
