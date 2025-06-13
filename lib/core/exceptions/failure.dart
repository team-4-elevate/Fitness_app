import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String errorMessage;

  const Failures({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  @override
  String toString() => errorMessage;
}

class ServerFailure extends Failures {
  const ServerFailure({required super.errorMessage});
}

class NetWorkError extends Failures {
  const NetWorkError({required super.errorMessage});
}
