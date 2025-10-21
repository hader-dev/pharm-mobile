import 'package:flutter/material.dart';

enum TextColors {
  primary(color: Color.fromARGB(255, 47, 47, 47)),
  secondary(color: Color.fromARGB(255, 80, 80, 80)),
  ternary(color: Color.fromARGB(255, 144, 144, 144)),
  white(color: Color.fromARGB(255, 255, 255, 255));

  final Color color;
  const TextColors({this.color = Colors.transparent});
}

enum StrokeColors {
  normal(color: Color(0xFFE5E5E5)),
  focused(color: Color.fromARGB(255, 22, 125, 133));

  final Color color;
  const StrokeColors({this.color = Colors.transparent});
}

enum SystemColors {
  defaultState(),
  orange(
    primary: Color.fromARGB(255, 255, 108, 61),
    secondary: Color.fromARGB(255, 255, 198, 180),
    ternary: Color.fromARGB(255, 255, 237, 232),
  ),
  yellow(
    primary: Color.fromARGB(255, 255, 184, 46),
    secondary: Color.fromARGB(255, 255, 234, 193),
    ternary: Color.fromARGB(255, 255, 248, 234),
  ),
  red(
    primary: Color.fromARGB(255, 240, 40, 73),
    secondary: Color.fromARGB(255, 245, 105, 128),
    ternary: Color.fromARGB(255, 254, 234, 237),
  ),
  green(
    primary: Color.fromARGB(255, 67, 159, 110),
    secondary: Color.fromARGB(255, 192, 236, 212),
    ternary: Color.fromARGB(255, 241, 255, 244),
  ),
  ;

  final Color primary;
  final Color secondary;
  final Color ternary;
  const SystemColors({
    this.primary = const Color(0xFF9E9E9E),
    this.secondary = Colors.grey,
    this.ternary = Colors.grey,
  });
}

class AppColors {
  //Background Colors
  static const bgWhite = Color(0xFFFFFFFF);
  static const bgDarken = Color(0xFFF2F4F7);
  static const bgDarken2 = Color(0xFFE6E6E6);
  static const bgDisabled = Color(0xFFE6E6E6);
  // Accent-1
  static const Color accent1Shade1 = Color(0xFF167D85);
  static const Color accent1Shade2 = Color(0xFF12646A);
  static const Color accent1Shade3 = Color(0xFFE8F2F3);
  static const Color accent1Shade2Deemphasized = Color(0xFF5F9599);

  // Accent Green
  static const Color accentGreenShade1 = Color(0xFF147082);
  static const Color accentGreenShade2 = Color(0xFF11606D);
  static const Color accentGreenShade3 = Color(0xFFE3EEF0);
}
