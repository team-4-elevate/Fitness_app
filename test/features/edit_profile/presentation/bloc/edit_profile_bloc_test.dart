// test/features/edit_profile/presentation/bloc/edit_profile_bloc_test.dart
import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/features/edit_profile/data/models/edit_profile/response/edit_profile_response.dart';
import 'package:fitness_app/features/edit_profile/data/models/upload_image/upload_image_response.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/edit_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/get_profile_data_usecase.dart';
import 'package:fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:fitness_app/features/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks(
    [EditProfileDataUseCase, UploadProfileImageUseCase, GetProfileDataUseCase])
import 'edit_profile_bloc_test.mocks.dart';

void main() {
  // Provide dummy values for generic ApiResult types to satisfy Mockito
  provideDummy<ApiResult<EditProfileResponse>>(ApiFailure('Dummy failure'));
  provideDummy<ApiResult<UploadImageResponse>>(ApiFailure('Dummy failure'));
  provideDummy<ApiResult<dynamic>>(ApiFailure('Dummy failure'));
  late EditProfileBloc bloc;
  late MockEditProfileDataUseCase mockEditProfileDataUseCase;
  late MockUploadProfileImageUseCase mockUploadProfileImageUseCase;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;

  setUp(() {
    mockEditProfileDataUseCase = MockEditProfileDataUseCase();
    mockUploadProfileImageUseCase = MockUploadProfileImageUseCase();
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();

    // Set up default behavior for get profile data
    final profileResponseMap = {
      'message': 'Profile data retrieved successfully',
      'user': {
        'firstName': 'Shimaa',
        'lastName': 'Hossni',
        'email': 'shimaa.hossni@example.com',
        'weight': 70,
        'goal': 'Gain weight',
        'activityLevel': 'Moderate'
      }
    };
    final profileResponse = EditProfileResponse.fromJson(profileResponseMap);
    when(mockGetProfileDataUseCase.call())
        .thenAnswer((_) async => ApiSuccess(profileResponse));

    bloc = EditProfileBloc(
      editProfileDataUseCase: mockEditProfileDataUseCase,
      uploadProfileImageUseCase: mockUploadProfileImageUseCase,
      getProfileDataUseCase: mockGetProfileDataUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('FetchProfileData', () {
    setUp(() {
      // Reset the bloc before each test
      bloc = EditProfileBloc(
        editProfileDataUseCase: mockEditProfileDataUseCase,
        uploadProfileImageUseCase: mockUploadProfileImageUseCase,
        getProfileDataUseCase: mockGetProfileDataUseCase,
      );
    });

    blocTest<EditProfileBloc, EditProfileState>(
      'emits loading, success states when profile data is fetched successfully',
      build: () => bloc,
      act: (bloc) => bloc.add(const FetchProfileDataEvent()),
      expect: () => [
        const EditProfileState(fetchProfileStatus: Status.loading),
        predicate<EditProfileState>((state) =>
            state.fetchProfileStatus == Status.success &&
            state.profileData != null),
        predicate<EditProfileState>((state) =>
            state.fetchProfileStatus == Status.success && 
            state.fieldValues != null),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase.call()).called(1);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'emits loading, error states when profile data fetch fails',
      build: () {
        // Override the default success behavior with failure
        when(mockGetProfileDataUseCase.call()).thenAnswer(
            (_) async => ApiFailure('Failed to fetch profile data'));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchProfileDataEvent()),
      expect: () => [
        const EditProfileState(fetchProfileStatus: Status.loading),
        predicate<EditProfileState>((state) =>
            state.fetchProfileStatus == Status.error &&
            state.errorMessage == 'Failed to fetch profile data' &&
            state.isErrorSnackbar == false),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase.call()).called(1);
      },
    );
  });

  group('EditProfileBloc', () {
    const firstName = 'Shimaa';
    const lastName = 'Hossni';
    const email = 'shimaa.hossni@example.com';
    const weight = '70';
    const goal = 'Gain weight';
    const activityLevel = 'Moderate';

    setUp(() {
      // Reset the bloc before each validation test
      bloc = EditProfileBloc(
        editProfileDataUseCase: mockEditProfileDataUseCase,
        uploadProfileImageUseCase: mockUploadProfileImageUseCase,
        getProfileDataUseCase: mockGetProfileDataUseCase,
      );
    });

    test('initial state should be correct', () {
      expect(bloc.state, equals(const EditProfileState()));
    });

    blocTest<EditProfileBloc, EditProfileState>(
      'emits loading,success states when UpdateProfileEvent is added',
      build: () {
        final responseMap = {'message': 'Profile updated successfully'};
        final mockResponse =
            ApiSuccess(EditProfileResponse.fromJson(responseMap));

        when(
          mockEditProfileDataUseCase(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            weight: anyNamed('weight'),
            goal: anyNamed('goal'),
            activityLevel: anyNamed('activityLevel'),
          ),
        ).thenAnswer((_) async => mockResponse);
        return bloc;
      },
      seed: () {
        // Start with a state that already has profile data
        final profileResponseMap = {
          'message': 'Profile data retrieved successfully',
          'user': {
            'firstName': 'Shimaa',
            'lastName': 'Hossni',
            'email': 'shimaa.hossni@example.com',
            'weight': 70,
            'goal': 'Gain weight',
            'activityLevel': 'Moderate'
          }
        };
        final profileResponse = EditProfileResponse.fromJson(profileResponseMap);
        
        return EditProfileState(
          profileData: profileResponse,
        );
      },
      act: (bloc) => bloc.add(
        const UpdateProfileEvent(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
          submitToApi: true,
        ),
      ),
      expect: () => [
        predicate<EditProfileState>((state) =>
            state.updateProfileStatus == Status.loading &&
            state.profileData != null),
        predicate<EditProfileState>((state) =>
            state.updateProfileStatus == Status.success &&
            state.snackbarMessage != null &&
            state.snackbarMessage!.contains('Profile updated successfully')),
      ],
      verify: (_) {
        verify(mockEditProfileDataUseCase(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        )).called(1);
        verifyNoMoreInteractions(mockEditProfileDataUseCase);
        verifyZeroInteractions(mockUploadProfileImageUseCase);
        verifyZeroInteractions(mockGetProfileDataUseCase);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'emits error state when there is no profile data available',
      build: () {
        // Create a new bloc instance with empty state
        return EditProfileBloc(
          editProfileDataUseCase: mockEditProfileDataUseCase,
          uploadProfileImageUseCase: mockUploadProfileImageUseCase,
          getProfileDataUseCase: mockGetProfileDataUseCase,
        );
      },
      act: (bloc) => bloc.add(
        const UpdateProfileEvent(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
          submitToApi: true,
        ),
      ),
      expect: () => [
        predicate<EditProfileState>((state) =>
            state.updateProfileStatus == Status.error &&
            state.errorMessage == 'No profile data available' &&
            state.snackbarMessage == 'No profile data available' &&
            state.isErrorSnackbar == true),
      ],
      verify: (_) {
        verifyNever(mockEditProfileDataUseCase(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          weight: anyNamed('weight'),
          goal: anyNamed('goal'),
          activityLevel: anyNamed('activityLevel'),
        ));
      },
    
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'emits loading, success states when UploadImageEvent is added and then attempts to fetch profile data',
      build: () {
        // Reset the bloc to start with clean state
        bloc = EditProfileBloc(
          editProfileDataUseCase: mockEditProfileDataUseCase,
          uploadProfileImageUseCase: mockUploadProfileImageUseCase,
          getProfileDataUseCase: mockGetProfileDataUseCase,
        );

        final responseMap = {'message': 'Profile image uploaded successfully'};
        final mockResponse =
            ApiSuccess(UploadImageResponse.fromJson(responseMap));

        when(
          mockUploadProfileImageUseCase(any),
        ).thenAnswer((_) async => mockResponse);

        // Stub the getProfileDataUseCase to return empty result to prevent auto-fetch
        when(mockGetProfileDataUseCase.call())
            .thenAnswer((_) async => ApiFailure('No auto-fetch in test'));

        return bloc;
      },
      seed: () => const EditProfileState(),
      act: (bloc) {
        final imageFile = File('path/to/image.jpg');
        return bloc.add(
          UploadProfileImageEvent(photo: imageFile),
        );
      },
      expect: () => [
        const EditProfileState(
          uploadImageStatus: Status.loading,
        ),
        predicate<EditProfileState>((state) =>
            state.uploadImageStatus == Status.success &&
            state.snackbarMessage != null &&
            state.snackbarMessage!
                .contains('Profile image uploaded successfully')),
        predicate<EditProfileState>((state) =>
            state.fetchProfileStatus == Status.loading),
        predicate<EditProfileState>((state) =>
            state.fetchProfileStatus == Status.error &&
            state.errorMessage == 'No auto-fetch in test'),
      ],
      verify: (_) {
        verify(mockUploadProfileImageUseCase(any)).called(1);
        verifyNoMoreInteractions(mockUploadProfileImageUseCase);
        verifyZeroInteractions(mockEditProfileDataUseCase);
        verifyZeroInteractions(mockGetProfileDataUseCase);
      },
    );

    blocTest<EditProfileBloc, EditProfileState>(
      'emits loading, error states when UploadImageEvent fails',
      build: () {
        // Reset the bloc to start with clean state
        bloc = EditProfileBloc(
          editProfileDataUseCase: mockEditProfileDataUseCase,
          uploadProfileImageUseCase: mockUploadProfileImageUseCase,
          getProfileDataUseCase: mockGetProfileDataUseCase,
        );

        when(
          mockUploadProfileImageUseCase(any),
        ).thenAnswer((_) async => ApiFailure('Upload image failed'));

        // Stub the getProfileDataUseCase to return empty result to prevent auto-fetch
        when(mockGetProfileDataUseCase.call())
            .thenAnswer((_) async => ApiFailure('No auto-fetch in test'));

        return bloc;
      },
      seed: () => const EditProfileState(),
      act: (bloc) {
        final imageFile = File('path/to/image.jpg');
        return bloc.add(
          UploadProfileImageEvent(photo: imageFile),
        );
      },
      expect: () => [
        const EditProfileState(
          uploadImageStatus: Status.loading,
        ),
        predicate<EditProfileState>((state) =>
            state.uploadImageStatus == Status.error &&
            state.errorMessage != null &&
            state.errorMessage!.contains('Upload image failed')),
      ],
      verify: (_) {
        verify(mockUploadProfileImageUseCase(any)).called(1);
        verifyNoMoreInteractions(mockUploadProfileImageUseCase);
        verifyZeroInteractions(mockEditProfileDataUseCase);
        verifyZeroInteractions(mockGetProfileDataUseCase);
      },
    );

    test('should pass correct parameters to edit profile data use case',
        () async {
      // Arrange
      final responseMap = {'message': 'Profile updated successfully'};
      final mockResponse =
          ApiSuccess(EditProfileResponse.fromJson(responseMap));
      when(mockEditProfileDataUseCase(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        weight: anyNamed('weight'),
        goal: anyNamed('goal'),
        activityLevel: anyNamed('activityLevel'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      bloc.add(
        const UpdateProfileEvent(
          firstName: firstName,
          lastName: lastName,
          email: email,
          weight: weight,
          goal: goal,
          activityLevel: activityLevel,
        ),
      );

      // Wait for use case to be called
      await untilCalled(mockEditProfileDataUseCase(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        weight: anyNamed('weight'),
        goal: anyNamed('goal'),
        activityLevel: anyNamed('activityLevel'),
      ));

      // Assert
      verify(mockEditProfileDataUseCase(
        firstName: firstName,
        lastName: lastName,
        email: email,
        weight: weight,
        goal: goal,
        activityLevel: activityLevel,
      )).called(1);
    });

    group('ValidationTests', () {
      blocTest<EditProfileBloc, EditProfileState>(
        'emits error state when first name is empty',
        build: () => bloc,
        seed: () => const EditProfileState(),
        act: (bloc) => bloc.add(
          const UpdateProfileEvent(
            firstName: '',
            lastName: lastName,
            email: email,
            weight: weight,
            goal: goal,
            activityLevel: activityLevel,
          ),
        ),
        expect: () => [
          predicate<EditProfileState>((state) =>
              state.updateProfileStatus == Status.error &&
              state.errorMessage == 'First name is required' &&
              state.isErrorSnackbar == false),
        ],
        verify: (_) {
          verifyZeroInteractions(mockEditProfileDataUseCase);
          verifyZeroInteractions(mockUploadProfileImageUseCase);
          verifyZeroInteractions(mockGetProfileDataUseCase);
        },
      );

      blocTest<EditProfileBloc, EditProfileState>(
        'emits error state when last name is empty',
        build: () => bloc,
        seed: () => const EditProfileState(),
        act: (bloc) => bloc.add(
          const UpdateProfileEvent(
            firstName: firstName,
            lastName: '',
            email: email,
            weight: weight,
            goal: goal,
            activityLevel: activityLevel,
          ),
        ),
        expect: () => [
          predicate<EditProfileState>((state) =>
              state.updateProfileStatus == Status.error &&
              state.errorMessage == 'Last name is required' &&
              state.isErrorSnackbar == false),
        ],
        verify: (_) {
          verifyZeroInteractions(mockEditProfileDataUseCase);
          verifyZeroInteractions(mockUploadProfileImageUseCase);
          verifyZeroInteractions(mockGetProfileDataUseCase);
        },
      );
    });
  });
}
