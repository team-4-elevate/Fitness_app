// test/features/edit_profile/domain/use_case/edit_profile_use_case_test.dart
import 'dart:io';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:fitness_app/features/edit_profile/domain/repo/editprofile_repo.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([EditProfileRepo])
import 'edit_profile_use_case_test.mocks.dart';

void main() {
  late MockEditProfileRepo mockRepo;
  late EditProfileDataUseCase editProfileDataUseCase;
  late UploadProfileImageUseCase uploadProfileImageUseCase;
  late GetProfileDataUseCase getProfileDataUseCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    editProfileDataUseCase = EditProfileDataUseCase(mockRepo);
    uploadProfileImageUseCase = UploadProfileImageUseCase(mockRepo);
    getProfileDataUseCase = GetProfileDataUseCase(mockRepo);
  });

  group('EditProfileDataUseCase', () {
    const firstName = 'Shimaa';
    const lastName = 'Hossni';
    const email = 'shimaa.hossni@example.com';
    const weight = '70';
    const goal = 'Gain weight';
    const activityLevel = 'Moderate';

    final responseMap = {'message': 'Profile updated successfully'};

    final mockResponse = ApiSuccess(EditProfileResponse.fromJson(responseMap));

    test(
        'should call editProfileData on the repository with correct parameters',
        () async {
      // Arrange
      when(mockRepo.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await editProfileDataUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      );

      // Assert
      expect(result, equals(mockResponse));
      verify(mockRepo.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(mockRepo.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).thenThrow(Exception('Update profile failed'));

      // Act & Assert
      expect(
        () => editProfileDataUseCase(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        ),
        throwsException,
      );
      verify(mockRepo.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group('UploadProfileImageUseCase', () {
    final imageFile = File('path/to/image.jpg');
    final responseMap = {'message': 'Image uploaded successfully'};
    final mockResponse = ApiSuccess(UploadImageResponse.fromJson(responseMap));

    test('should call uploadProfileImage on the repository', () async {
      // Arrange
      when(mockRepo.uploadProfileImage(imageFile))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await uploadProfileImageUseCase(imageFile);

      // Assert
      expect(result, equals(mockResponse));
      verify(mockRepo.uploadProfileImage(imageFile)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(mockRepo.uploadProfileImage(imageFile))
          .thenThrow(Exception('Upload image failed'));

      // Act & Assert
      expect(
        () => uploadProfileImageUseCase(imageFile),
        throwsException,
      );
      verify(mockRepo.uploadProfileImage(imageFile)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });

  group('GetProfileDataUseCase', () {
    final responseMap = {
      'user': {
        'firstName': 'Shimaa',
        'lastName': 'Hossni',
        'email': 'shimaa.hossni@example.com',
        'weight': '70',
        'goal': 'Gain weight',
        'activityLevel': 'Moderate'
      },
      'message': 'Profile retrieved successfully'
    };
    final mockResponse = ApiSuccess(EditProfileResponse.fromJson(responseMap));

    test('should call getProfileData on the repository', () async {
      // Arrange
      when(mockRepo.getProfileData()).thenAnswer((_) async => mockResponse);

      // Act
      final result = await getProfileDataUseCase();

      // Assert
      expect(result, equals(mockResponse));
      verify(mockRepo.getProfileData()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should throw exception when repository throws', () async {
      // Arrange
      when(mockRepo.getProfileData())
          .thenThrow(Exception('Get profile failed'));

      // Act & Assert
      expect(
        () => getProfileDataUseCase(),
        throwsException,
      );
      verify(mockRepo.getProfileData()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
