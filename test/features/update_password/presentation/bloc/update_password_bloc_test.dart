import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/enums/update_password_ui_fields.dart';
import 'package:fitness_app/features/update_password/domain/use_case/update_password_use_case.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_bloc.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_event.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([UpdatePasswordUseCase])
import 'update_password_bloc_test.mocks.dart';

void main() {
  late UpdatePasswordBloc bloc;
  late MockUpdatePasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockUpdatePasswordUseCase();
    bloc = UpdatePasswordBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('UpdatePasswordBloc', () {
    const oldPassword = 'OldPass@@@@123!';
    const newPassword = 'NewPass@@@@@@@@@123!';
    const confirmPassword = 'NewPass123!';

    test('initial state should be correct', () {
      expect(bloc.state, equals(const UpdatePasswordState()));
    });

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'emits loading,success states when UpdatePasswordSubmitEvent is added',
      build: () {
        when(
          mockUseCase(any),
        ).thenAnswer((_) async => {});
        return bloc;
      },
      seed: () => const UpdatePasswordState(arePasswordsMatching: true),
      act: (bloc) => bloc.add(
        const UpdatePasswordSubmitEvent(
          oldPassword: oldPassword,
          newPassword: newPassword,
        ),
      ),
      expect: () => [
        const UpdatePasswordState(
          updatePasswordStatus: Status.loading,
          arePasswordsMatching: true,
        ),
        const UpdatePasswordState(
          updatePasswordStatus: Status.success,
          arePasswordsMatching: true,
        ),
      ],
      verify: (_) {
        verify(mockUseCase(any)).called(1);
        verifyNoMoreInteractions(mockUseCase);
      },
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'emits loading, error states when UpdatePasswordSubmitEvent is added and fails',
      build: () {
        when(
          mockUseCase(any),
        ).thenThrow(Exception('Update password failed'));
        return bloc;
      },
      seed: () => const UpdatePasswordState(arePasswordsMatching: true),
      act: (bloc) => bloc.add(
        const UpdatePasswordSubmitEvent(
          oldPassword: oldPassword,
          newPassword: newPassword,
        ),
      ),
      expect: () => [
        const UpdatePasswordState(
          updatePasswordStatus: Status.loading,
          arePasswordsMatching: true,
        ),
        UpdatePasswordState(
          updatePasswordStatus: Status.error,
          errorMessage: 'Exception: Update password failed',
          arePasswordsMatching: true,
        ),
      ],
      verify: (_) {
        verify(mockUseCase(any)).called(1);
        verifyNoMoreInteractions(mockUseCase);
      },
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'does not call use case when validation fails',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.add(
        const UpdatePasswordSubmitEvent(
          oldPassword: '',
          newPassword: '',
        ),
      ),
      expect: () => [
        const UpdatePasswordState(
          oldPasswordError: 'Password is required',
          newPasswordError: 'Password is required',
        ),
      ],
      verify: (_) {
        verifyZeroInteractions(mockUseCase);
      },
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'toggles old password visibility',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const TogglePassVisibilityEvent(type: UpdatePassUiType.oldPass),
      ),
      expect: () => [
        const UpdatePasswordState(isOldPasswordVisible: true),
      ],
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'toggles new password visibility',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const TogglePassVisibilityEvent(type: UpdatePassUiType.newPass),
      ),
      expect: () => [
        const UpdatePasswordState(isNewPasswordVisible: true),
      ],
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'toggles confirm password visibility',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const TogglePassVisibilityEvent(type: UpdatePassUiType.confirmPass),
      ),
      expect: () => [
        const UpdatePasswordState(isConfirmPasswordVisible: true),
      ],
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'validates confirm password match',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ValidateConfirmPasswordEvent(
          confirmPassword: confirmPassword,
          newPassword: newPassword,
        ),
      ),
      expect: () => [
        const UpdatePasswordState(
          confirmPasswordError: null,
          arePasswordsMatching: true,
        ),
      ],
    );

    blocTest<UpdatePasswordBloc, UpdatePasswordState>(
      'handles non-matching passwords',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ValidateConfirmPasswordEvent(
          confirmPassword: 'DifferentPassword123!',
          newPassword: newPassword,
        ),
      ),
      expect: () => [
        const UpdatePasswordState(
          confirmPasswordError: 'Passwords do not match',
          arePasswordsMatching: false,
        ),
      ],
    );

    test('should pass correct request to use case', () async {
      bloc.emit(const UpdatePasswordState(arePasswordsMatching: true));
      when(mockUseCase(any)).thenAnswer((_) async => {});
      bloc.add(
        const UpdatePasswordSubmitEvent(
          oldPassword: oldPassword,
          newPassword: newPassword,
        ),
      );
      await untilCalled(mockUseCase(any));
      final captured = verify(mockUseCase(captureAny)).captured;
      expect(captured.length, 1);
      final capturedRequest = captured.first as UpdatePasswordRequest;
      expect(capturedRequest.oldPassword, equals(oldPassword));
      expect(capturedRequest.newPassword, equals(newPassword));
    });
  });
} 