import 'package:flutter/material.dart';

import '../../utils/shared_prefs.dart';

class ThemeManager {
  Future<String> setTheme(String theme) async {
    await Prefs.setString(SPKeys.theme, theme.toString());
    return theme;
  }

  String get currentTheme {
    return Prefs.getString(SPKeys.theme) ?? ThemeMode.light.name;
  }

  String getTheme() {
    String themeCode = Prefs.getString(SPKeys.theme) ?? ThemeMode.light.name;
    return themeCode;
  }
}
