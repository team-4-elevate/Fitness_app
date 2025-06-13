import 'package:equatable/equatable.dart';


// this is Better than the regular BaseState class
sealed class AppStates<T> extends Equatable{
  const AppStates();
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T? data) success,
    required R Function(String? error) error,
  }) {
    if (this is InitialState) {
      return initial();
    } else if (this is LoadingState) {
      return loading();
    } else if (this is SuccessState<T>) {
      return success((this as SuccessState<T>).data);
    } else if (this is ErrorState) {
      return error((this as ErrorState).error);
    }

    throw Exception('Unknown state type');
  }

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T? data)? success,
    R Function(String? error)? error,
  }) {
    if (this is InitialState) {
      return initial?.call();
    } else if (this is LoadingState) {
      return loading?.call();
    } else if (this is SuccessState<T>) {
      return success?.call((this as SuccessState<T>).data);
    } else if (this is ErrorState) {
      return error?.call((this as ErrorState).error);
    }

    return null;
  }

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T? data)? success,
    R Function(String? error)? error,
    required R Function() orElse,
  }) {
    if (this is InitialState && initial != null) {
      return initial();
    } else if (this is LoadingState && loading != null) {
      return loading();
    } else if (this is SuccessState<T> && success != null) {
      return success((this as SuccessState<T>).data);
    } else if (this is ErrorState && error != null) {
      return error((this as ErrorState).error);
    }

    return orElse();
  }
}

class InitialState<T> extends AppStates<T> {
  const InitialState();

  @override
  bool operator ==(Object other) => other is InitialState;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'AppStates<$T>.initial()';
  
  @override
  List<Object?> get props => [];

}

class LoadingState<T> extends AppStates<T> {
  const LoadingState();

  @override
  bool operator ==(Object other) => other is LoadingState;

  @override
  int get hashCode => 1;

  @override
  String toString() => 'AppStates<$T>.loading()';

  AppStates<T> copyWith() {
    return const LoadingState();
  }
  
  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends AppStates<T> {
  final T?data;
  const SuccessState([this.data]);

  @override
  bool operator ==(Object other) =>
      other is SuccessState<T> && other.data == data;

  @override
  int get hashCode => data?.hashCode ?? 2;

  @override
  String toString() => 'AppStates<$T>.success(data: $data)';

  SuccessState<T> copyWith({T? data}) {
    return SuccessState<T>(data ?? this.data);
  }
  
  @override
  List<Object?> get props => [
    data,
  ];
}

class ErrorState<T> extends AppStates<T> {
  final String? error;
  const ErrorState(this.error);

  @override
  bool operator ==(Object other) => other is ErrorState && other.error == error;

  @override
  int get hashCode => error?.hashCode ?? 3;

  @override
  String toString() => 'AppStates<$T>.error(error: $error)';

  ErrorState<T> copyWith({String? error}) {
    return ErrorState<T>(error ?? this.error);
  }
  
  @override
  List<Object?> get props => [
    error,
  ];
}

AppStates<T> initialState<T>() => InitialState<T>();
AppStates<T> loadingState<T>() => LoadingState<T>();
AppStates<T> successState<T>([T? data]) => SuccessState<T>(data);
AppStates<T> errorState<T>(String? error) => ErrorState<T>(error);
