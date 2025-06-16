import 'package:equatable/equatable.dart';

sealed class BaseState<T> extends Equatable {
  const BaseState();
}

final class BaseInitialState<T> extends BaseState<T> {
  const BaseInitialState();

  @override
  List<Object?> get props => [];
}

final class BaseLoadingState<T> extends BaseState<T> {
  const BaseLoadingState();

  @override
  List<Object?> get props => [];
}

final class BaseSuccessState<T> extends BaseState<T> {
  const BaseSuccessState({this.data});
  final T? data;

  @override
  List<Object?> get props => [data];
}

final class BaseErrorState<T> extends BaseState<T> {
  const BaseErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
