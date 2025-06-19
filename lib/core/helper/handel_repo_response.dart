import 'api_result.dart';

ApiResult<T> handleRepoResponse<T>(ApiResult<T> response) {
  try {
    return response.when(
      success: (data) => ApiSuccess(data),
      failure: (message) => ApiFailure(message),
    );
  } catch (e) {
    return ApiFailure(e.toString());
  }
}

ApiResult<R> handleRepoTransformedResponse<T, R>(
  ApiResult<T> response,
  R Function(T data) transform,
) {
  try {
    return response.map(transform);
  } catch (e) {
    return ApiFailure(
      'Error transforming repository response: ${e.toString()}',
    );
  }
}

T maybeWhen<T, D>(
  ApiResult<D> result, {
  T Function(D data)? success,
  T Function(String error)? failure,
  required T Function() orElse,
}) {
  try {
    if (result is ApiSuccess && success != null) {
      return success((result as ApiSuccess<D>).data);
    } else if (result is ApiFailure && failure != null) {
      return failure((result as ApiFailure<D>).message);
    } else {
      return orElse();
    }
  } catch (e) {
    return orElse();
  }
}

extension ApiResultExtensions<T> on ApiResult<T> {
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(String error)? failure,
    required R Function() orElse,
  }) {
    try {
      if (this is ApiSuccess && success != null) {
        return success((this as ApiSuccess<T>).data);
      } else if (this is ApiFailure && failure != null) {
        return failure((this as ApiFailure<T>).message);
      } else {
        return orElse();
      }
    } catch (e) {
      return orElse();
    }
  }

  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(String error)? failure,
  }) {
    try {
      if (this is ApiSuccess && success != null) {
        return success((this as ApiSuccess<T>).data);
      } else if (this is ApiFailure && failure != null) {
        return failure((this as ApiFailure<T>).message);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  bool get isSuccess => this is ApiSuccess<T>;

  bool get isFailure => this is ApiFailure<T>;

  T? get dataOrNull {
    try {
      return isSuccess ? (this as ApiSuccess<T>).data : null;
    } catch (e) {
      return null;
    }
  }

  String? get errorOrNull {
    try {
      return isFailure ? (this as ApiFailure<T>).message : null;
    } catch (e) {
      return null;
    }
  }

  T getDataOr(T defaultValue) {
    try {
      return dataOrNull ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  ApiResult<T> thenDo(void Function(T data) action) {
    try {
      if (isSuccess) {
        action((this as ApiSuccess<T>).data);
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  ApiResult<T> onError(void Function(String error) action) {
    try {
      if (isFailure) {
        action((this as ApiFailure<T>).message);
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  Future<ApiResult<T>> get toFuture {
    try {
      return Future.value(this);
    } catch (e) {
      return Future.value(ApiFailure(e.toString()));
    }
  }

  Future<ApiResult<R>> asyncMap<R>(Future<R> Function(T data) transform) async {
    try {
      if (isSuccess) {
        try {
          final result = await transform((this as ApiSuccess<T>).data);
          return ApiSuccess<R>(result);
        } catch (e) {
          return ApiFailure<R>(' ${e.toString()}');
        }
      } else {
        return ApiFailure<R>((this as ApiFailure<T>).message);
      }
    } catch (e) {
      return ApiFailure<R>(e.toString());
    }
  }

  ApiResult<R> andThen<R>(ApiResult<R> Function(T data) nextOperation) {
    try {
      if (isSuccess) {
        return nextOperation((this as ApiSuccess<T>).data);
      } else {
        return ApiFailure<R>((this as ApiFailure<T>).message);
      }
    } catch (e) {
      return ApiFailure<R>(e.toString());
    }
  }

  Future<ApiResult<T>> thenDoAsync(Future<void> Function(T data) action) async {
    try {
      if (isSuccess) {
        await action((this as ApiSuccess<T>).data);
      }
      return this;
    } catch (e) {
      return this;
    }
  }
}

extension ApiResultListExtensions<T> on ApiResult<List<T>> {
  ApiResult<List<T>> filter(bool Function(T item) predicate) {
    try {
      if (isSuccess) {
        final filteredList =
            (this as ApiSuccess<List<T>>).data.where(predicate).toList();
        return ApiSuccess<List<T>>(filteredList);
      } else {
        return this;
      }
    } catch (e) {
      return ApiFailure<List<T>>('Filter operation failed: ${e.toString()}');
    }
  }

  ApiResult<List<T>> sortBy(int Function(T a, T b) compare) {
    try {
      if (isSuccess) {
        final sortedList = List.of((this as ApiSuccess<List<T>>).data)
          ..sort(compare);
        return ApiSuccess<List<T>>(sortedList);
      } else {
        return this;
      }
    } catch (e) {
      return ApiFailure<List<T>>(e.toString());
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
