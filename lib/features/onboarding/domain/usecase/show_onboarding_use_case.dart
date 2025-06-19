import 'package:fitness_app/features/onboarding/domain/repository/onboarding_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowOnboardingUseCase {
  final OnboardingRepo _onboardingRepo;

  ShowOnboardingUseCase(this._onboardingRepo);

  Future<void> call() async {
    await _onboardingRepo.showOnboarding();
  }
}
