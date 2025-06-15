import 'package:equatable/equatable.dart';

sealed class BaseState<T> extends Equatable {
  const BaseState();
}

final class InitialState<T> extends BaseState<T> {
  const InitialState();

  @override
  List<Object?> get props => [];
}

final class LoadingState<T> extends BaseState<T> {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

final class SuccessState<T> extends BaseState<T> {
  const SuccessState(this.data);
  final T data;

  @override
  List<Object?> get props => [data];
}

final class ErrorState<T> extends BaseState<T> {
  const ErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

// extension BaseStateExtensions<T> on BaseState<T> {
//   /// Check if state is initial
//   bool get isInitial => this is InitialState<T>;

//   /// Check if state is loading
//   bool get isLoading => this is LoadingState<T>;

//   /// Check if state is success
//   bool get isSuccess => this is SuccessState<T>;

//   /// Check if state is error
//   bool get isError => this is ErrorState<T>;

//   /// Get data if success, null otherwise
//   T? get dataOrNull {
//     if (this is SuccessState<T>) {
//       return (this as SuccessState<T>).data;
//     }
//     return null;
//   }

//   /// Get error message if error, null otherwise
//   String? get errorOrNull {
//     if (this is ErrorState<T>) {
//       return (this as ErrorState<T>).error;
//     }
//     return null;
//   }

//   /// Pattern matching like Rust/Kotlin
//   R when<R>({
//     required R Function() initial,
//     required R Function() loading,
//     required R Function(T data) success,
//     required R Function(String error) errorHandler,
//   }) {
//     return switch (this) {
//       InitialState<T>() => initial(),
//       LoadingState<T>() => loading(),
//       SuccessState<T>(data: final data) => success(data),
//       ErrorState<T>(error: final error) => errorHandler(error),
//     };
//   }

//   /// Pattern matching like Rust/Kotlin with optional handlers
//   R match<R>({
//     R Function()? initial,
//     R Function()? loading,
//     R Function(T? data)? success,
//     R Function(String? error)? error,
//     required R Function() orElse,
//   }) {
//     return switch (this) {
//       InitialState<T>() => initial?.call() ?? orElse(),
//       LoadingState<T>() => loading?.call() ?? orElse(),
//       SuccessState<T>(data: final data) => success?.call(data) ?? orElse(),
//       ErrorState<T>(error: final errorMsg) => error?.call(errorMsg) ?? orElse(),
//     };
//   }

//   /// Pattern matching like Rust/Kotlin with optional handlers and default
//   R maybeWhen<R>({
//     R Function()? initial,
//     R Function()? loading,
//     R Function(T? data)? success,
//     R Function(String? error)? error,
//     required R Function() orElse,
//   }) {
//     if (this is InitialState<T> && initial != null) {
//       return initial();
//     } else if (this is LoadingState<T> && loading != null) {
//       return loading();
//     } else if (this is SuccessState<T> && success != null) {
//       return success((this as SuccessState<T>).data);
//     } else if (this is ErrorState<T> && error != null) {
//       return error((this as ErrorState<T>).error);
//     }
//     return orElse();
//   }

//   /// Check if state is of type T
//   bool isTypeOf<T>() {
//     return this is T;
//   }
//   /// Get the state as type T if possible
//   /// Returns null if not of type T
//   T? asType<T>() {
//     if (this is T) {
//       return this as T;
//     }
//     return null;
//   }

//   /// Get the state as type T with a default value if not of type T
//   T asTypeOrDefault<T>(T defaultValue) {
//     if (this is T) {
//       return this as T;
//     }
//     return defaultValue;
//   }

//   /// Get the state as type T with a default value if not of type T
//   T asTypeOrThrow<T>() {
//     if (this is T) {
//       return this as T;
//     }
//     throw Exception('State is not of type ${T.runtimeType}');
// //   }

// }
