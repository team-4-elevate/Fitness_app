import 'package:bloc/bloc.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/forgetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/resetpassword_request.dart';
import 'package:fitness_app/features/auth/data/model/forgetPassword/verify_otp_request.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/app_manger/bloc_handler_mixin.dart';
import '../../../domain/usecases/forgot_password_use_case.dart';
import '../../../domain/usecases/reset_password_use_case.dart';
import '../../../domain/usecases/verify_otp_use_case.dart';
import 'forget_password_event.dart';
import 'forget_password_state.dart';

@singleton
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgotPasswordUseCase _forgetPasswordUseCase;
  final VerifyOtpUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  // final ResendOtpUseCase _resendOtpUseCase;
  ForgetPasswordBloc(
    this._forgetPasswordUseCase,
    this._verifyResetCodeUseCase,
    this._resetPasswordUseCase,
    // this._resendOtpUseCase,
  ) : super(ForgetPasswordState()) {
    _mapEvents();
  }
  Future<void> _onForgetPasswordSubmit(
    ForgetPasswordSubmitEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    try {
      emit(state.copyWith(forgetPasswordStatus: Status.loading));
      await _forgetPasswordUseCase(ForgetpasswordRequest(email: event.email));
      emit(
        state.copyWith(
          forgetPasswordStatus: Status.success,
          userEmail: event.email,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          forgetPasswordStatus: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          verifyOtpStatus: Status.loading,
          shouldVerify: event.code.length == 4 ? true : false,
        ),
      );
      await _verifyResetCodeUseCase(VerifyOtpRequest(resetCode: event.code));
      emit(state.copyWith(verifyOtpStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          verifyOtpStatus: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(state.copyWith(resetPasswordStatus: Status.loading));
    try {
      await _resetPasswordUseCase(
        ResetpasswordRequest(
          email: state.userEmail,
          newPassword: event.newPassword,
        ),
      );
      emit(state.copyWith(resetPasswordStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          resetPasswordStatus: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    try {
      await _forgetPasswordUseCase(
        ForgetpasswordRequest(email: state.userEmail),
      );
      emit(state.copyWith(resendOtpStatus: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          resendOtpStatus: Status.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _mapEvents() {
    on<ForgetPasswordSubmitEvent>(_onForgetPasswordSubmit);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ResendOtpEvent>(_onResendOtp);
  }
}
