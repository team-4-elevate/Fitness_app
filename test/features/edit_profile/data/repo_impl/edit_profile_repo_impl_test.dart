// test/features/edit_profile/data/repo_impl/edit_profile_repo_impl_test.dart
import 'dart:io';
import 'package:fitness_app/features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_interface.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:fitness_app/features/edit_profile/data/repo/editprofile_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([EditProfileRemoteDataSourceInterface])
import 'edit_profile_repo_impl_test.mocks.dart';

void main() {
  late EditProfileRepoImpl repository;
  late MockEditProfileRemoteDataSourceInterface mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSourceInterface();
    repository = EditProfileRepoImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('EditProfileRepositoryImpl', () {
    const firstName = 'Shimaa';
    const lastName = 'Hossni';
    const email = 'shimaa.hossni@example.com';
    const weight = '70';
    const goal = 'Gain weight';
    const activityLevel = 'Moderate';

    final mockResponseMap = {'message': 'Profile updated successfully'};

    final mockResponse = EditProfileResponse.fromJson(mockResponseMap);

    test('editProfile calls remote data source and returns result', () async {
      when(mockRemoteDataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).thenAnswer((_) async => mockResponse);

      final result = await repository.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      );

      expect(result.dataOrNull, equals(mockResponse));
      verify(mockRemoteDataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('editProfile propagates exceptions from remote data source', () async {
      when(mockRemoteDataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).thenThrow(Exception('Failed to update profile'));

      final result = await repository.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      );

      expect(result.errorOrNull, isNotNull);
      expect(result.dataOrNull, isNull);
      verify(mockRemoteDataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('uploadImage calls remote data source and returns result', () async {
      final imageFile = File('path/to/image.jpg');
      final mockImageResponseMap = {'message': 'Image uploaded successfully'};
      final mockImageResponse =
          UploadImageResponse.fromJson(mockImageResponseMap);

      when(mockRemoteDataSource.uploadProfileImage(imageFile))
          .thenAnswer((_) async => mockImageResponse);

      final result = await repository.uploadProfileImage(imageFile);
      expect(result.dataOrNull, equals(mockImageResponse));
      verify(mockRemoteDataSource.uploadProfileImage(imageFile)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('uploadImage propagates exceptions from remote data source', () async {
      final imageFile = File('path/to/image.jpg');
      when(mockRemoteDataSource.uploadProfileImage(imageFile))
          .thenThrow(Exception('Failed to upload image'));

      final result = await repository.uploadProfileImage(imageFile);

      expect(result.errorOrNull, isNotNull);
      expect(result.dataOrNull, isNull);
      verify(mockRemoteDataSource.uploadProfileImage(imageFile)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('getProfile calls remote data source and returns result', () async {
      final userResponseMap = {
        'user': {
          'firstName': 'Shimaa',
          'lastName': 'Hossni',
          'email': 'shimaa.hossni@example.com'
        },
        'message': 'Profile retrieved successfully'
      };
      final userResponse = EditProfileResponse.fromJson(userResponseMap);

      when(mockRemoteDataSource.getProfileData())
          .thenAnswer((_) async => userResponse);

      final result = await repository.getProfileData();

      expect(result.dataOrNull, equals(userResponse));
      verify(mockRemoteDataSource.getProfileData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('getProfile propagates exceptions from remote data source', () async {
      when(mockRemoteDataSource.getProfileData())
          .thenThrow(Exception('Failed to get profile'));

      final result = await repository.getProfileData();

      expect(result.errorOrNull, isNotNull);
      expect(result.dataOrNull, isNull);
      verify(mockRemoteDataSource.getProfileData()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
