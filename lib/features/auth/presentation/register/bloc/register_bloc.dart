// features/auth/presentation/register/bloc/register_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/base_states/base_state.dart';
import 'package:fitness_app/features/auth/data/model/register/register_response/register_response.dart';
import 'package:fitness_app/features/auth/data/model/register_details.dart';
import 'package:fitness_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:injectable/injectable.dart';

part 'register_event.dart';
part 'register_state.dart';

@injectable
class RegisterBloc extends Bloc<RegisterEvent, RegisterStateType> {
  final RegisterUseCase _registerUseCase;
  
  RegisterBloc(this._registerUseCase) : super(const BaseInitialState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterStateType> emit,
  ) async {
    emit(const BaseLoadingState());
    
    final result = await _registerUseCase(event.data);
    
    result.when(
      success: (data) => emit(SuccessState(data)),
      failure: (error) => emit(BaseErrorState(error)),
    );
  }
}
