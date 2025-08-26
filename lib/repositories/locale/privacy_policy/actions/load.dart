import 'package:flutter/services.dart';

Future<String> loadPrivacyPolicy([String langCode = 'fr']) async {
  String code = langCode;

  if (!['ar', 'fr', 'en'].contains(langCode)) {
    code = 'fr';
  }

  return await rootBundle.loadString('assets/markup/privacy_policy/$code.md');
}
