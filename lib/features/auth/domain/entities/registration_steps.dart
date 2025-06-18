// features/auth/domain/entities/registration_steps.dart
import 'package:fitness_app/generated/l10n/app_localizations.dart';

class RegistrationSteps {
  static List<String> getTitles(AppLocalizations localizations) {
    return [
      localizations.registrationTitle1,
      localizations.registrationTitle2,
      localizations.registrationTitle3,
      localizations.registrationTitle4,
      localizations.registrationTitle5,
      localizations.registrationTitle6,
    ];
  }

  static List<String> getSubtitles(AppLocalizations localizations) {
    return [
      localizations.registrationSubtitle1,
      localizations.registrationSubtitle2,
      localizations.registrationSubtitle3,
      localizations.registrationSubtitle4,
      localizations.registrationSubtitle5,
      localizations.registrationSubtitle6,
    ];
  }

  static String getTitleForStep(int step, AppLocalizations localizations) {
    final titles = getTitles(localizations);
    if (step >= 1 && step <= titles.length) {
      return titles[step - 1];
    }
    return '';
  }

  static String getSubtitleForStep(int step, AppLocalizations localizations) {
    final subtitles = getSubtitles(localizations);
    if (step >= 1 && step <= subtitles.length) {
      return subtitles[step - 1];
    }
    return '';
  }
}
