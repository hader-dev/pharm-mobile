import '../../utils/shared_prefs.dart';

class LanguageHelper {
  static final List<String> supportedLanguages = <String>['en', 'fr', 'ar'];

  static String getCurrentLanguage() {
    return Prefs.getString(SPKeys.language) ?? supportedLanguages.first;
  }

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'français';
      case 'ar':
        return 'العربية';
      default:
        return 'Unknown';
    }
  }

  static Future<void> setCurrentLanguage(String languageCode) {
    if (supportedLanguages.contains(languageCode)) {
      return Prefs.setString(SPKeys.language, languageCode);
    } else {
      throw Exception('Unsupported language code');
    }
  }
}
