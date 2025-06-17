import 'package:fitness_app/core/app_local_storage/app_local_storage.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/onboarding_repo.dart';

@Injectable(as: OnboardingRepo)
class OnboardingRepoImp implements OnboardingRepo {
  final AppLocalStorage _appLocalStorage;

  OnboardingRepoImp(this._appLocalStorage);

  @override
  Future<void> showOnboarding() {
    return _appLocalStorage.setShowOnboarding(true);
  }
}
