import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class LocalizationManager extends ChangeNotifier {
  static final LocalizationManager _instance = LocalizationManager._internal();
  factory LocalizationManager() => _instance;
  LocalizationManager._internal();

  static const String _languageKey = 'selected_language';

  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  List<Locale> get supportedLocales => const [Locale('en'), Locale('ar')];

  bool get isArabic => _currentLocale.languageCode == 'ar';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  /// Initialize the localization manager
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString(_languageKey) ?? 'en';
    _currentLocale = Locale(savedLanguage);
    notifyListeners();
  }

  /// Change the current locale
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;

    _currentLocale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, locale.languageCode);
    notifyListeners();
  }

  /// Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final newLocale = isArabic ? const Locale('en') : const Locale('ar');
    await setLocale(newLocale);
  }

  /// Get localized string using current locale (for use without BuildContext)
  String getLocalizedString(String key, [Map<String, String>? params]) {
    // This is a simplified version - in practice you might want to load
    // the ARB files directly or use a different approach
    final isAr = isArabic;

    final messages = isAr ? _arabicMessages : _englishMessages;
    String text = messages[key] ?? key;

    if (params != null && params.isNotEmpty) {
      params.forEach((paramKey, value) {
        text = text.replaceAll('{$paramKey}', value);
      });
    }

    return text;
  }

  // Basic fallback messages - in production, you might load these from ARB files
  static const Map<String, String> _englishMessages = {
    'app_title': 'Fitness App',
    'welcome': 'Welcome to Fitness App',
    'hello': 'Hello',
    // Add more as needed
  };

  static const Map<String, String> _arabicMessages = {
    'app_title': 'تطبيق اللياقة البدنية',
    'welcome': 'مرحبا بك في تطبيق اللياقة البدنية',
    'hello': 'مرحبا',
    // Add more as needed
  };
}
