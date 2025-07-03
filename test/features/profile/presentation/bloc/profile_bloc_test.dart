import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/base_states/app_states.dart';
import 'package:fitness_app/core/helper/api_result.dart';
import 'package:fitness_app/core/services/localization_manager.dart';
import 'package:fitness_app/features/profile/domain/usecases/logout_use_case.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:fitness_app/features/profile/presentation/bloc/profile_navigation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_bloc_test.mocks.dart';

@GenerateMocks([LogoutUseCase, LocalizationManager])
void main() {
  late ProfileBloc profileBloc;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockLocalizationManager mockLocalizationManager;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    mockLocalizationManager = MockLocalizationManager();
    profileBloc = ProfileBloc(mockLogoutUseCase, mockLocalizationManager);
  });

  tearDown(() {
    profileBloc.close();
  });

  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiFailure<void>('Dummy failure'));
  });

  group('ProfileBloc', () {
    test('initial state should be ProfileState with null values', () {
      expect(profileBloc.state, const ProfileState());
      expect(profileBloc.state.logoutState, isNull);
      expect(profileBloc.state.languageChangedState, isNull);
      expect(profileBloc.state.navigationState, isNull);
    });

    group('LogoutTappedEvent', () {
      blocTest<ProfileBloc, ProfileState>(
        'should emit [loading, success with navigation] when logout succeeds',
        build: () {
          when(mockLogoutUseCase.call()).thenAnswer(
            (_) async => ApiSuccess<void>(null),
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(LogoutTappedEvent()),
        expect: () => [
          const ProfileState(logoutState: LoadingState()),
          predicate<ProfileState>((state) =>
              state.logoutState is SuccessState &&
              state.navigationState is ToLoginAfterLogout),
        ],
        verify: (_) {
          verify(mockLogoutUseCase.call()).called(1);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'should emit [loading, error] when logout fails',
        build: () {
          when(mockLogoutUseCase.call()).thenAnswer(
            (_) async => ApiFailure<void>('Network error'),
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(LogoutTappedEvent()),
        expect: () => [
          const ProfileState(logoutState: LoadingState()),
          const ProfileState(logoutState: ErrorState('Network error')),
        ],
        verify: (_) {
          verify(mockLogoutUseCase.call()).called(1);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'should emit [loading, error] when logout throws exception',
        build: () {
          when(mockLogoutUseCase.call()).thenThrow(
            Exception('Unexpected error'),
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(LogoutTappedEvent()),
        expect: () => [
          const ProfileState(logoutState: LoadingState()),
          const ProfileState(
            logoutState: ErrorState('Exception: Unexpected error'),
          ),
        ],
        verify: (_) {
          verify(mockLogoutUseCase.call()).called(1);
        },
      );
    });

    group('ChangeLanguageTappedEvent', () {
      blocTest<ProfileBloc, ProfileState>(
        'should emit success state when language change succeeds',
        build: () {
          when(mockLocalizationManager.toggleLanguage()).thenAnswer(
            (_) async {},
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(ChangeLanguageTappedEvent()),
        expect: () => [
          const ProfileState(languageChangedState: SuccessState()),
        ],
        verify: (_) {
          verify(mockLocalizationManager.toggleLanguage()).called(1);
        },
      );

      blocTest<ProfileBloc, ProfileState>(
        'should emit error state when language change fails',
        build: () {
          when(mockLocalizationManager.toggleLanguage()).thenThrow(
            Exception('Language change failed'),
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(ChangeLanguageTappedEvent()),
        expect: () => [
          const ProfileState(
            languageChangedState:
                ErrorState('Exception: Language change failed'),
          ),
        ],
        verify: (_) {
          verify(mockLocalizationManager.toggleLanguage()).called(1);
        },
      );
    });

    group('EditProfileTappedEvent', () {
      blocTest<ProfileBloc, ProfileState>(
        'should emit navigation state to edit profile',
        build: () => profileBloc,
        act: (bloc) => bloc.add(EditProfileTappedEvent()),
        expect: () => [
          predicate<ProfileState>(
              (state) => state.navigationState is ToEditProfile),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'should update navigation state when called multiple times',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(EditProfileTappedEvent());
          bloc.add(EditProfileTappedEvent());
        },
        expect: () => [
          predicate<ProfileState>(
              (state) => state.navigationState is ToEditProfile),
          predicate<ProfileState>(
              (state) => state.navigationState is ToEditProfile),
        ],
      );
    });

    group('ChangePasswordTappedEvent', () {
      blocTest<ProfileBloc, ProfileState>(
        'should emit navigation state to update password',
        build: () => profileBloc,
        act: (bloc) => bloc.add(ChangePasswordTappedEvent()),
        expect: () => [
          predicate<ProfileState>(
              (state) => state.navigationState is ToUpdatePassword),
        ],
      );
    });
    group('Complex Scenarios', () {
      blocTest<ProfileBloc, ProfileState>(
        'should update navigation state when called multiple times',
        build: () => profileBloc,
        act: (bloc) {
          bloc.add(EditProfileTappedEvent());
          bloc.add(EditProfileTappedEvent()); // Same event twice
        },
        expect: () => [
          // First call
          predicate<ProfileState>(
              (state) => state.navigationState is ToEditProfile),
          // Second call - new timestamp
          predicate<ProfileState>(
              (state) => state.navigationState is ToEditProfile),
        ],
      );
    });

    group('State Properties', () {
      test('should create ProfileState with copyWith correctly', () {
        const initialState = ProfileState();
        final updatedState = initialState.copyWith(
          logoutState: const LoadingState(),
          navigationState: ToEditProfile(),
        );

        expect(updatedState.logoutState, const LoadingState());
        expect(updatedState.navigationState, isA<ToEditProfile>());
        expect(updatedState.languageChangedState, isNull);
      });

      test('should maintain existing values in copyWith when not provided', () {
        final initialState = ProfileState(
          logoutState: const SuccessState(),
          languageChangedState: const SuccessState(),
          navigationState: ToEditProfile(),
        );

        final updatedState = initialState.copyWith(
          logoutState: const LoadingState(),
        );

        expect(updatedState.logoutState, const LoadingState());
        expect(updatedState.languageChangedState, const SuccessState());
        expect(updatedState.navigationState, isA<ToEditProfile>());
      });
    });

    group('Error Handling', () {
      blocTest<ProfileBloc, ProfileState>(
        'should handle logout use case returning success',
        build: () {
          when(mockLogoutUseCase.call()).thenAnswer(
            (_) async => ApiSuccess<void>(null),
          );
          return profileBloc;
        },
        act: (bloc) => bloc.add(LogoutTappedEvent()),
        expect: () => [
          const ProfileState(logoutState: LoadingState()),
          predicate<ProfileState>((state) =>
              state.logoutState is SuccessState &&
              state.navigationState is ToLoginAfterLogout),
        ],
      );
    });
  });
}
