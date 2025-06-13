# Flutter Localization Setup

This document explains how localization has been set up in your Fitness App.

## Overview

The app now supports internationalization (i18n) with English and Arabic languages using Flutter's official localization system.

## Files Structure

```
lib/
├── l10n/
│   ├── app_en.arb          # English translations
│   └── app_ar.arb          # Arabic translations
├── core/
│   ├── services/
│   │   ├── localization_service.dart      # Legacy API localization service (updated)
│   │   └── localization_manager.dart      # New localization manager
│   ├── utils/
│   │   └── context_extensions.dart        # Helper extensions for BuildContext
│   └── widgets/
│       └── localization_demo.dart         # Demo widget showing all translations
└── main.dart                              # App entry point with localization setup

l10n.yaml                                  # Localization configuration
pubspec.yaml                              # Dependencies and flutter generate: true
```

## Key Features

### 1. Official Flutter Localization
- Uses `flutter_localizations` and `intl` packages
- ARB (Application Resource Bundle) files for translations
- Automatic code generation with `flutter gen-l10n`

### 2. Dual Language Support
- **English (en)**: Default language
- **Arabic (ar)**: RTL support included

### 3. Dynamic Language Switching
- Runtime language switching without app restart
- Persistent language preference using SharedPreferences
- Provider pattern for state management

### 4. Backward Compatibility
- Updated `ApiLocalizationService` to work with new system
- Falls back to old translation maps if new system fails
- Seamless integration with existing error handling

## Usage

### Basic Usage in Widgets

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Text(l10n.appTitle); // Uses current locale
  }
}
```

### Using Context Extensions

```dart
import '../core/utils/context_extensions.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.welcome);
  }
}
```

### Language Switching

```dart
import 'package:provider/provider.dart';
import '../core/services/localization_manager.dart';

// Toggle between English and Arabic
await Provider.of<LocalizationManager>(context, listen: false).toggleLanguage();

// Set specific language
await Provider.of<LocalizationManager>(context, listen: false).setLocale(Locale('ar'));
```

### Error Messages with Localization

```dart
import '../core/services/localization_service.dart';

// Still works with existing code
String errorMessage = ApiLocalizationService().translate('errors.no_internet');

// Or use new system
String errorMessage = AppLocalizations.of(context).networkError;
```

## Adding New Translations

### 1. Add to ARB Files

**lib/l10n/app_en.arb:**
```json
{
  "newKey": "New English Text",
  "@newKey": {
    "description": "Description of the new key"
  }
}
```

**lib/l10n/app_ar.arb:**
```json
{
  "newKey": "النص الجديد بالعربية"
}
```

### 2. Regenerate Localization Files

```bash
flutter gen-l10n
```

### 3. Use in Code

```dart
Text(AppLocalizations.of(context).newKey)
```

## Parameterized Messages

### ARB File:
```json
{
  "welcomeUser": "Welcome {userName}!",
  "@welcomeUser": {
    "description": "Welcome message with user name",
    "placeholders": {
      "userName": {
        "type": "String",
        "description": "The user's name"
      }
    }
  }
}
```

### Usage:
```dart
Text(l10n.welcomeUser('John Doe'))
```

## RTL Support

The app automatically detects Arabic locale and applies RTL layout:

```dart
// Check if current locale is RTL
bool isRTL = context.isRTL;

// Get current language code
String langCode = context.languageCode;
```

## Configuration Files

### l10n.yaml
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/l10n/generated/
nullable-getter: false
```

### pubspec.yaml
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0

flutter:
  generate: true
```

## Testing Localization

1. Run the app: `flutter run`
2. Navigate to the LocalizationDemo screen
3. Tap the language toggle button
4. Observe all strings switching between English and Arabic
5. Verify RTL layout for Arabic

## Best Practices

1. **Always provide descriptions** in ARB files for translators
2. **Use meaningful keys** that describe the content
3. **Group related translations** using prefixes (e.g., `errors.`, `buttons.`)
4. **Test both languages** thoroughly
5. **Consider text expansion** - Arabic text is typically 20-30% longer
6. **Use placeholder parameters** for dynamic content
7. **Provide fallback values** for missing translations

## Troubleshooting

### Generated files not found
```bash
flutter clean
flutter pub get
flutter gen-l10n
```

### Import errors
Make sure to import from the generated location:
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

### Language not switching
Ensure the app is wrapped with ChangeNotifierProvider and Consumer:
```dart
ChangeNotifierProvider(
  create: (_) => LocalizationManager(),
  child: Consumer<LocalizationManager>(...),
)
```

## Next Steps

1. Add more languages by creating new ARB files (e.g., `app_fr.arb`)
2. Implement date/time localization using `intl` package
3. Add number formatting for different locales
4. Consider using Flutter's built-in widgets like `LocalizationsOverride`
5. Add unit tests for localization logic
