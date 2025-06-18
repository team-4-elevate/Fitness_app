class RequestResult<T> {
  final T? data;
  final String? errorMessage;
  final bool isSuccess;

  RequestResult({this.data, this.errorMessage, required this.isSuccess});

  factory RequestResult.success(T data) =>
      RequestResult(data: data, isSuccess: true);

  factory RequestResult.error(String message) =>
      RequestResult(errorMessage: message, isSuccess: false);

  bool get isError => !isSuccess;
}