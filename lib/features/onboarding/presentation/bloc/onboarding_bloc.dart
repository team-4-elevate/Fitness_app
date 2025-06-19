import 'package:fitness_app/features/onboarding/domain/usecase/show_onboarding_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final ShowOnboardingUseCase _showOnboardingUseCase;
  OnboardingBloc(this._showOnboardingUseCase) : super(OnboardingInitial()) {
    on<OnboardingEvent>((event, emit) {
      if (event is ShowOnboardingCompleted) {
        _showOnboardingUseCase.call();
      }
    });
  }
}
