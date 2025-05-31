import 'package:flutter/material.dart';

extension BuildContextHelper on BuildContext {
  // AppLocalizations? get translation => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;
}
