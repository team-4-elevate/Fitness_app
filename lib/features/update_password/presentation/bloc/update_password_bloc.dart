import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/use_case/update_password_use_case.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_event.dart';
import 'package:fitness_app/features/update_password/presentation/bloc/update_password_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UpdatePasswordUseCase _updatePasswordUseCase;

  UpdatePasswordBloc(this._updatePasswordUseCase)
      : super(const UpdatePasswordState()) {
    on<UpdatePasswordSubmitEvent>(_onUpdatePasswordSubmit);
    on<ToggleOldPasswordVisibilityEvent>(_onToggleOldPasswordVisibility);
    on<ToggleNewPasswordVisibilityEvent>(_onToggleNewPasswordVisibility);
    on<ToggleConfirmPasswordVisibilityEvent>(
        _onToggleConfirmPasswordVisibility);
    on<ValidateConfirmPasswordEvent>(_onValidateConfirmPassword);
  }

  Future<void> _onUpdatePasswordSubmit(
    UpdatePasswordSubmitEvent event,
    Emitter<UpdatePasswordState> emit,
  ) async {
    final oldPasswordError = AppValidators.validatePassword(event.oldPassword);
    final newPasswordError = AppValidators.validatePassword(event.newPassword);

    if (oldPasswordError != null ||
        newPasswordError != null ||
        !state.arePasswordsMatching) {
      emit(state.copyWith(
        oldPasswordError: oldPasswordError,
        newPasswordError: newPasswordError,
      ));
      return;
    }

    try {
      emit(state.copyWith(updatePasswordStatus: Status.loading));
      await _updatePasswordUseCase(
        UpdatePasswordRequest(
          email: event.email,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        ),
      );
      emit(
        state.copyWith(
          updatePasswordStatus: Status.success,
          userEmail: event.email,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          updatePasswordStatus: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onToggleOldPasswordVisibility(
    ToggleOldPasswordVisibilityEvent event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible));
  }

  void _onToggleNewPasswordVisibility(
    ToggleNewPasswordVisibilityEvent event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibilityEvent event,
    Emitter<UpdatePasswordState> emit,
  ) {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void _onValidateConfirmPassword(
    ValidateConfirmPasswordEvent event,
    Emitter<UpdatePasswordState> emit,
  ) {
    String? error;
    if (event.confirmPassword.isEmpty) {
      error = 'Please confirm your password';
    } else if (event.confirmPassword != event.newPassword) {
      error = 'Passwords do not match';
      emit(state.copyWith(
        confirmPasswordError: error,
        arePasswordsMatching: false,
      ));
      return;
    }

    emit(state.copyWith(
      confirmPasswordError: error,
      arePasswordsMatching: true,
    ));
  }
}
