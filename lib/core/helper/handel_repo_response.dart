import 'api_result.dart';

ApiResult<T> handleRepoResponse<T>(ApiResult<T> response) {
  return response.when(
    success: (data) => ApiSuccess(data),
    failure: (message) => ApiFailure(message),
  );
}

ApiResult<R> handleRepoTransformedResponse<T, R>(
  ApiResult<T> response,
  R Function(T data) transform,
) {
  return response.map(transform);
}

T maybeWhen<T, D>(
  ApiResult<D> result, {
  T Function(D data)? success,
  T Function(String error)? failure,
  required T Function() orElse,
}) {
  if (result is ApiSuccess && success != null) {
    return success((result as ApiSuccess<D>).data);
  } else if (result is ApiFailure && failure != null) {
    return failure((result as ApiFailure<D>).message);
  } else {
    return orElse();
  }
}

extension ApiResultExtensions<T> on ApiResult<T> {
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(String error)? failure,
    required R Function() orElse,
  }) {
    if (this is ApiSuccess && success != null) {
      return success((this as ApiSuccess<T>).data);
    } else if (this is ApiFailure && failure != null) {
      return failure((this as ApiFailure<T>).message);
    } else {
      return orElse();
    }
  }

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String error)? failure,
  }) {
    if (this is ApiSuccess && success != null) {
      return success((this as ApiSuccess<T>).data);
    } else if (this is ApiFailure && failure != null) {
      return failure((this as ApiFailure<T>).message);
    } else {
      return null;
    }
  }

  bool get isSuccess => this is ApiSuccess<T>;

  bool get isFailure => this is ApiFailure<T>;

  T? get dataOrNull => isSuccess ? (this as ApiSuccess<T>).data : null;

  String? get errorOrNull => isFailure ? (this as ApiFailure<T>).message : null;

  T getDataOr(T defaultValue) => dataOrNull ?? defaultValue;

  ApiResult<T> thenDo(void Function(T data) action) {
    if (isSuccess) {
      action((this as ApiSuccess<T>).data);
    }
    return this;
  }

  ApiResult<T> onError(void Function(String error) action) {
    if (isFailure) {
      action((this as ApiFailure<T>).message);
    }
    return this;
  }

  Future<ApiResult<T>> get toFuture => Future.value(this);

  Future<ApiResult<R>> asyncMap<R>(Future<R> Function(T data) transform) async {
    if (isSuccess) {
      try {
        final result = await transform((this as ApiSuccess<T>).data);
        return ApiSuccess<R>(result);
      } catch (e) {
        return ApiFailure<R>(e.toString());
      }
    } else {
      return ApiFailure<R>((this as ApiFailure<T>).message);
    }
  }

  ApiResult<R> andThen<R>(ApiResult<R> Function(T data) nextOperation) {
    if (isSuccess) {
      return nextOperation((this as ApiSuccess<T>).data);
    } else {
      return ApiFailure<R>((this as ApiFailure<T>).message);
    }
  }
}

extension ApiResultListExtensions<T> on ApiResult<List<T>> {
  ApiResult<List<T>> filter(bool Function(T item) predicate) {
    if (isSuccess) {
      final filteredList =
          (this as ApiSuccess<List<T>>).data.where(predicate).toList();
      return ApiSuccess<List<T>>(filteredList);
    } else {
      return this;
    }
  }

  ApiResult<List<T>> sortBy(int Function(T a, T b) compare) {
    if (isSuccess) {
      final sortedList = List.of((this as ApiSuccess<List<T>>).data)
        ..sort(compare);
      return ApiSuccess<List<T>>(sortedList);
    } else {
      return this;
    }
  }
}

ApiSuccess<T> success<T>(T data) => ApiSuccess<T>(data);

ApiFailure<T> failure<T>(String message) => ApiFailure<T>(message);

Future<ApiResult<T>> tryAsyncOperation<T>(
  Future<T> Function() operation, {
  String? Function(Object error)? errorMessage,
}) async {
  try {
    final result = await operation();
    return ApiSuccess<T>(result);
  } catch (e) {
    final message =
        errorMessage != null ? errorMessage(e) ?? e.toString() : e.toString();
    return ApiFailure<T>(message);
  }
}
