import 'package:flutter/material.dart' show debugPrint;
import '../base_states/app_states.dart';
import 'api_result.dart';

Future<void> handleCubitStates<T>({
  required Future<ApiResult<T>> Function() request,
  required void Function(AppStates<T> newState) emit,
  void Function(T? data)? onSuccess,
  void Function(String? error)? onError,
}) async {
  try {
    debugPrint("🔄 handleCubitStates: Starting request for type $T");

    // Send loading state
    emit(loadingState<T>());
    debugPrint("✅ Loading state sent");

    // Execute request
    final result = await request();
    debugPrint("📦 Request completed, processing result...");

    // Process result
    await result.when(
      success: (data) async {
        debugPrint("🎉 Request succeeded! Data type: ${data.runtimeType}");
        if (data is List) {
          debugPrint("Number of items: ${data.length}");
        }

        try {
          if (onSuccess != null) {
            debugPrint("callback onSuccess is on...");
            await Future.microtask(() => onSuccess(data));
            debugPrint("✅ Success callback executed");
          }

          debugPrint("Sending success state..");
          emit(successState<T>(data));
          debugPrint("Success state sent successfully");
        } catch (callbackError, stackTrace) {
          debugPrint("Error Catching Callback: $callbackError");
          debugPrint("Error StackTrace: $stackTrace");
          emit(
            errorState<T>(
              " Error Catching Callback: ${callbackError.toString()}",
            ),
          );
        }
      },
      failure: (message) async {
        debugPrint("Request failed : $message");

        try {
          if (onError != null) {
            debugPrint("callback onError is on...");
            await Future.microtask(() => onError(message));
            debugPrint("Successfully executed onError callback");
          }

          emit(errorState<T>(message));
          debugPrint("Successfully sent error state with message: $message");
        } catch (callbackError) {
          debugPrint("Error in onError callback: $callbackError");
          emit(
            errorState<T>(
              "Error in onError callback: ${callbackError.toString()}",
            ),
          );
        }
      },
    );

    debugPrint(" handleCubitStates Ended Successfully for type $T");
  } catch (e, stackTrace) {
    debugPrint("Expiation in handleCubitStates: $e");
    debugPrint("📍 Stack Trace: $stackTrace");

    final errorMessage = " ${e.toString()}";

    try {
      if (onError != null) {
        onError(errorMessage);
      }
      emit(errorState<T>(errorMessage));
      debugPrint("✅ Exception error state sent");
    } catch (emitError) {
      debugPrint("💥 Failed to send error state: $emitError");
    }
  }
}

/// ```dart
/// class MyCubit extends Cubit<AppStates<UserData>> {
///   Future<void> fetchData() => handleCubitStates(
///     request: () => _repository.getUserData(),
///     emit: (newState) => emit(state.copyWith(
///      AnyStatus: newState,)),
///     onSuccess: (data) {
///       // on success callback
///       // u can emit state here with data and save data or as u Like
///       if (data?.token != null) {
///         _storage.saveToken(data!.token);
///       }
///     },
///     onError: (error) {
///       // on error callback
///       // u can log error or show message
///       // or emit error state
///
///       logError('Failed to get user data', error);
///     },
///   );
/// }
/// ```
