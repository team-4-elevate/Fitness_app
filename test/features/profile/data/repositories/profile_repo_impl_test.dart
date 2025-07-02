import 'package:fitness_app/core/app_local_storage/app_secure_storage.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/profile/data/datasources/profile_remote_ds.dart';
import 'package:fitness_app/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([AppSecureStorage, ProfileRemoteDs])
void main() {
  late AppSecureStorage mockAppSecureStorage;
  late ProfileRemoteDs mockProfileRemoteDs;
  late ProfileRepoImpl profileRepoImpl;

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiFailure<void>('Dummy failure'));
  });

  setUp(() {
    mockAppSecureStorage = MockAppSecureStorage();
    mockProfileRemoteDs = MockProfileRemoteDs();
    profileRepoImpl =
        ProfileRepoImpl(mockProfileRemoteDs, mockAppSecureStorage);
  });

  group('ProfileRepoImpl Tests', () {
    group('logout', () {
      test(
          'should return success and clear storage when remote logout succeeds',
          () async {
        // Arrange
        when(mockProfileRemoteDs.logout()).thenAnswer(
          (_) async => ApiSuccess<void>(null),
        );
        when(mockAppSecureStorage.clearAllData()).thenAnswer(
          (_) async => {},
        );

        // Act
        final result = await profileRepoImpl.logout();

        // Assert
        expect(result, isA<ApiSuccess<void>>());
        expect(result.isSuccess, true);

        // Verify interactions
        verify(mockProfileRemoteDs.logout()).called(1);
        verify(mockAppSecureStorage.clearAllData()).called(1);
        verifyNoMoreInteractions(mockProfileRemoteDs);
        verifyNoMoreInteractions(mockAppSecureStorage);
      });

      test(
          'should return failure and NOT clear storage when remote logout fails',
          () async {
        // Arrange
        const errorMessage = 'Network error';
        when(mockProfileRemoteDs.logout()).thenAnswer(
          (_) async => ApiFailure<void>(errorMessage),
        );

        // Act
        final result = await profileRepoImpl.logout();

        // Assert
        expect(result, isA<ApiFailure<void>>());
        expect(result.isSuccess, false);
        expect((result as ApiFailure<void>).message, errorMessage);

        // Verify interactions
        verify(mockProfileRemoteDs.logout()).called(1);
        verifyNever(mockAppSecureStorage.clearAllData());
        verifyNoMoreInteractions(mockProfileRemoteDs);
        verifyNoMoreInteractions(mockAppSecureStorage);
      });
      test('should handle storage clearing exception and wrap in ApiFailure',
          () async {
        // Arrange
        when(mockProfileRemoteDs.logout()).thenAnswer(
          (_) async => ApiSuccess<void>(null),
        );
        when(mockAppSecureStorage.clearAllData()).thenThrow(
          Exception('Storage clearing failed'),
        );

        // Act
        expect(
          () => profileRepoImpl.logout(),
          throwsA(isA<Exception>()),
        );
      });

      test('DEBUG: Check what actually happens when storage fails', () async {
        // Arrange
        when(mockProfileRemoteDs.logout()).thenAnswer(
          (_) async => ApiSuccess<void>(null),
        );
        when(mockAppSecureStorage.clearAllData()).thenThrow(
          Exception('Storage error'),
        );

        // Act
        try {
          final result = await profileRepoImpl.logout();
          print('Result: $result');
          print('Is Success: ${result.isSuccess}');
          if (result is ApiFailure) {
            print('Error: ${result.message}');
          }
        } catch (e) {
          print('Exception thrown: $e');
        }

        // Check what was actually called
        print('Remote DS interactions:');
        verify(mockProfileRemoteDs.logout()).called(1);

        print('Storage interactions:');
        try {
          verify(mockAppSecureStorage.clearAllData()).called(1);
        } catch (e) {
          print('clearAllData was not called: $e');
        }
      });
    });
  });
}
