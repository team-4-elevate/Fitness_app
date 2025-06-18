import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/request_result.dart';

mixin BlocHandler<E extends Equatable, S extends AppState> on Bloc<E, S> {
  Future<RequestResult> handleRequest<T, D, EX>(
    Emitter emit,
    T Function(Status s, {String? err, D? data, EX? extraData}) updater,
    Future Function() useCase, {
    bool? notValidCase = false,
    String? validationErrMsg,
    bool showLoading = true,
    EX? extraData,
  }) async {
    log('called handle request');
    if (showLoading) emit(updater(Status.loading));
    try {
      final res = await useCase();
      emit(
        updater(
          Status.success,
          data: isVoidOrNull(useCase, res) ? null : res,
          extraData: extraData,
        ),
      );
      return RequestResult.success(res);
    } catch (e) {
      log('catch');
      emit(updater(Status.error, err: e.toString()));
      log('catch');
      return RequestResult.error(validationErrMsg ?? 'something went wrong');
    }
  }

  // _checkNullability<T, S>(
  //   T res,
  //   Function repoCall,
  //   Emitter emit,
  //   S Function(Status) updater,
  // ) {
  //   const String emptyDataMessage = 'No data returned';
  //   if (!isVoid(repoCall) && res == null) {
  //     emit(updater(Status.error));
  //     emit(state.copyWith(errorMessage: emptyDataMessage));
  //     throw RequestResult.error(emptyDataMessage);
  //   }
  // }

  bool isVoidOrNull(Function f, RequestResult? res) {
    String type = f.runtimeType.toString();
    return type.contains('void') ||
        type.contains('Future<void>') ||
        res == null;
  }
}

abstract class AppState extends Equatable {
  final String errorMessage = '';
  const AppState();
  copyWith({
    String? errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];
}

enum Status {
  initial,
  loading,
  success,
  error,
}
extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
}