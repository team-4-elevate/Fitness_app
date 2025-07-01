import 'package:fitness_app/core/app_data/common_response/reset_password_response.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/repo_interface/update_password_repo_interface.dart';
import 'package:fitness_app/features/update_password/domain/use_case/update_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UpdatePasswordRepoInterface])
import 'update_password_use_case_test.mocks.dart';

void main() {
  late UpdatePasswordUseCase useCase;
  late MockUpdatePasswordRepoInterface mockRepo;

  setUp(() {
    mockRepo = MockUpdatePasswordRepoInterface();
    useCase = UpdatePasswordUseCase(mockRepo);
  });

  group('UpdatePasswordUseCase', () {
    final request = UpdatePasswordRequest(
      oldPassword: 'OldPass@#^@^#@#123',
      newPassword: 'NewPassDGRSDGR#%123',
    );

    test('call updatePassword on the repository', () async {
      when(mockRepo.updatePassword(request)).thenAnswer((_) async => {});
      await useCase(request);
      verify(mockRepo.updatePassword(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('throw exception when repository throws', () async {
      when(mockRepo.updatePassword(request))
          .thenThrow(Exception('Update password failed'));
      expect(() => useCase(request), throwsException);
      verify(mockRepo.updatePassword(request)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
} 