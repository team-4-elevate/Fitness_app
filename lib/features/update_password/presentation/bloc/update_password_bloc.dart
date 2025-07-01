import 'package:bloc/bloc.dart';
import 'package:fitness_app/core/app_manger/bloc_handler_mixin.dart';
import 'package:fitness_app/core/utils/app_validator.dart';
import 'package:fitness_app/features/update_password/data/models/update_password_request.dart';
import 'package:fitness_app/features/update_password/domain/enums/update_password_ui_fields.dart';
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
    _mapEvents();
  }

  Future<void> _onUpdatePasswordSubmit(
    UpdatePasswordSubmitEvent event,
    Emitter<UpdatePasswordState> emit,
  ) async {
    if (!_validateUpdateSubmit(event, emit)) return;
    try {
      emit(state.copyWith(updatePasswordStatus: Status.loading));
      await _updatePasswordUseCase(
        UpdatePasswordRequest(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword));
      emit(
        state.copyWith(
          updatePasswordStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          updatePasswordStatus: Status.error,
          errorMessage: e.toString()));
    }
  }

  void _onTogglePassVisibility(
      TogglePassVisibilityEvent event, Emitter<UpdatePasswordState> emit) {
    if (event.type.isOld) {
      emit(state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible));
      return;
    } else if (event.type.isNew) {
      emit(state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible));
      return;
    } else {
      emit(state.copyWith(
          isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
      return;
    }
  }

  void _onValidatePasswordsMatch(
    ValidateConfirmPasswordEvent event,
    Emitter<UpdatePasswordState> emit) {
    String? confirmError;
    if (event.confirmPassword.isEmpty) {
      confirmError = 'Please confirm your password';
    } else if (event.confirmPassword != event.newPassword) {
      confirmError = 'Passwords do not match';
      emit(state.copyWith(
        confirmPasswordError: confirmError,
        arePasswordsMatching: false));
      return;
    }
    emit(state.copyWith(
      confirmPasswordError: confirmError,
      arePasswordsMatching: true));
  }

  bool _validateUpdateSubmit(UpdatePasswordSubmitEvent event, Emitter emit) {
    final oldPasswordError = AppValidators.validatePassword(event.oldPassword);
    final newPasswordError = AppValidators.validatePassword(event.newPassword);
    emit(state.copyWith(
      oldPasswordError: oldPasswordError,
      newPasswordError: newPasswordError));
    return (oldPasswordError == null &&
        newPasswordError == null &&
        state.arePasswordsMatching);
  }

  void _mapEvents() {
    on<UpdatePasswordSubmitEvent>(_onUpdatePasswordSubmit);
    on<TogglePassVisibilityEvent>(_onTogglePassVisibility);
    on<ValidateConfirmPasswordEvent>(_onValidatePasswordsMatch);
  }
}
