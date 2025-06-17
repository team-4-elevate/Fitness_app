// features/auth/presentation/register/bloc/register_event.dart
part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final RegisterDetailsData data;
  
  const RegisterSubmitted(this.data);

  @override
  List<Object> get props => [data];
}
