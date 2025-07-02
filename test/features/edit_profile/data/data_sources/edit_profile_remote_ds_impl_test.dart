// test/features/edit_profile/data/data_sources/edit_profile_remote_ds_impl_test.dart
import 'dart:io';
import 'package:fitness_app/core/api/api_client.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/datasource/remote_data_source/edit_profile_remote_data_source_impl.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../food_recommendation/data/datasources/food_recommend_remote_data_source_impl_test.mocks.dart';

class MockFile extends Mock implements File {
  @override
  String get path => 'test/mock_image.jpg';
}

@GenerateMocks([ApiClient])
void main() {
  provideDummy<ApiResult<dynamic>>(ApiFailure('Dummy failure'));

  late EditProfileRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = EditProfileRemoteDataSourceImpl(mockApiClient);
  });

  group('EditProfileRemoteDataSourceImpl', () {
    const firstName = 'Shimaa';
    const lastName = 'Hossni';
    const email = 'shimaa.hossni@example.com';
    const weight = '70';
    const goal = 'Gain weight';
    const activityLevel = 'Moderate';

    test('editProfileData makes correct API call and returns data on success',
        () async {
      final mockResponseData = {'message': 'Profile updated successfully'};
      final mockResponse = EditProfileResponse.fromJson(mockResponseData);

      when(mockApiClient.put(
        any,
        data: anyNamed('data'),
      )).thenAnswer((_) async => ApiSuccess(mockResponseData));

      final result = await dataSource.editProfileData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      );

      expect(result.message, equals(mockResponse.message));
      verify(mockApiClient.put(
        any,
        data: anyNamed('data'),
      )).called(1);
    });

    test('editProfileData throws exception on API failure', () async {
      when(mockApiClient.put(
        any,
        data: anyNamed('data'),
      )).thenAnswer((_) async => ApiFailure('Failed to update profile'));

      expect(
        () => dataSource.editProfileData(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        ),
        throwsA(isA<Exception>()),
      );

      verify(mockApiClient.put(
        any,
        data: anyNamed('data'),
      )).called(1);
    });

    test('uploadProfileImage should return UploadImageResponse on success',
        () async {
      final mockResponseData = {'message': 'Image uploaded successfully'};
      final expectedResponse = UploadImageResponse.fromJson(mockResponseData);
      expect(expectedResponse.message, equals('Image uploaded successfully'));
    });

    test('uploadProfileImage handles exceptions properly', () {
      final mockErrorResponse = ApiFailure('Upload image failed');
      expect(mockErrorResponse.message, equals('Upload image failed'));
    });

    test('uploadProfileImage API failure handling', () {
      final mockErrorResponse = ApiFailure('Failed to upload image');
      expect(mockErrorResponse.message, equals('Failed to upload image'));

      expect(
        () => throw Exception('Failed to upload profile image'),
        throwsA(isA<Exception>()),
      );
    });

    test('getProfileData makes correct API call and returns data on success',
        () async {
      final mockResponseData = {
        'message': 'Profile data retrieved successfully',
        'user': {
          'firstName': 'Shimaa',
          'lastName': 'Hossni',
          'email': 'shimaa.hossni@example.com'
        }
      };
      final mockResponse = EditProfileResponse.fromJson(mockResponseData);

      when(mockApiClient.get(any))
          .thenAnswer((_) async => ApiSuccess(mockResponseData));
      final result = await dataSource.getProfileData();
      expect(result.user!.firstName, equals(mockResponse.user!.firstName));
      verify(mockApiClient.get(any)).called(1);
    });

    test('getProfileData throws exception on API failure', () async {
      when(mockApiClient.get(any))
          .thenAnswer((_) async => ApiFailure('Failed to get profile data'));
      expect(
        () => dataSource.getProfileData(),
        throwsA(isA<Exception>()),
      );

      verify(mockApiClient.get(any)).called(1);
    });
  });
}
