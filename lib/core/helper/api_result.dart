import 'package:equatable/equatable.dart';

sealed class ApiResult<T> extends Equatable {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
  }) {
    return switch (this) {
      ApiSuccess<T>(data: var data) => success(data),
      ApiFailure<T>(message: var message) => failure(message),
    };
  }

  ApiResult<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      ApiSuccess<T>(data: var data) => ApiSuccess(transform(data)),
      ApiFailure<T>(message: var message) => ApiFailure(message),
    };
  }

  T? get dataOrNull => switch (this) {
    ApiSuccess<T>(data: var data) => data,
    ApiFailure<T>() => null,
  };

  T getDataOr(T defaultValue) => switch (this) {
    ApiSuccess<T>(data: var data) => data,
    ApiFailure<T>() => defaultValue,
  };

  String? get errorOrNull => switch (this) {
    ApiSuccess<T>() => null,
    ApiFailure<T>(message: var message) => message,
  };

  bool get isSuccess => this is ApiSuccess<T>;

  bool get isFailure => this is ApiFailure<T>;
}

final class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);

  @override
  String toString() => 'ApiSuccess(data: $data)';

  @override
  List<Object?> get props => [data];
}

final class ApiFailure<T> extends ApiResult<T> {
  final String message;
  const ApiFailure(this.message);

  @override
  String toString() => 'ApiFailure(message: $message)';

  @override
  List<Object?> get props => [message];
}
