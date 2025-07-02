import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/profile/domain/repositories/profile_repo.dart';
import 'package:fitness_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepo])
void main() {
  late MockProfileRepo mockProfileRepo;
  late LogoutUseCase logoutUseCase;

  setUp(() {
    mockProfileRepo = MockProfileRepo();
    logoutUseCase = LogoutUseCase(mockProfileRepo);
  });

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiFailure<void>('Dummy failure'));
  });

  group('LogoutUseCase Tests', () {
    test('should call ProfileRepo and return success when logout succeeds', () async {
      when(mockProfileRepo.logout()).thenAnswer(
        (_) async => ApiSuccess<void>(null),
      );

      final result = await logoutUseCase.call(); 

      expect(result, isA<ApiSuccess<void>>());
      expect(result.isSuccess, true);
      
      verify(mockProfileRepo.logout()).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should call ProfileRepo and return failure when logout fails', () async {
      const errorMessage = 'Network error';
      when(mockProfileRepo.logout()).thenAnswer(
        (_) async => ApiFailure<void>(errorMessage),
      );
      final result = await logoutUseCase.call();

      expect(result, isA<ApiFailure<void>>());
      expect(result.isSuccess, false);
      expect((result as ApiFailure<void>).message, errorMessage);
      
      verify(mockProfileRepo.logout()).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    test('should handle exceptions thrown by ProfileRepo', () async {
      when(mockProfileRepo.logout()).thenThrow(
        Exception('Unexpected error'),
      );

      expect(
        () => logoutUseCase.call(),
        throwsA(isA<Exception>()),
      );
      
      verify(mockProfileRepo.logout()).called(1);
      verifyNoMoreInteractions(mockProfileRepo);
    });

    // test('should pass through all repository result types', () async {
    //   // Test for success with message
    //   when(mockProfileRepo.logout()).thenAnswer(
    //     (_) async => ApiSuccess<void>(null),
    //   );

    //   final successResult = await logoutUseCase.call();
      
    //   expect(successResult, isA<ApiSuccess<void>>());
    //   expect(successResult, 'Logged out successfully');
      
    //   verify(mockProfileRepo.logout()).called(1);
      
    //   // Reset mock for next test
    //   reset(mockProfileRepo);
      
    //   // Test for failure
    //   when(mockProfileRepo.logout()).thenAnswer(
    //     (_) async => ApiFailure<void>('Server error'),
    //   );

    //   final failureResult = await logoutUseCase.call();
      
    //   expect(failureResult, isA<ApiFailure<void>>());
    //   expect((failureResult as ApiFailure<void>).message, 'Server error');
      
    //   verify(mockProfileRepo.logout()).called(1);
    // });
  });
}
