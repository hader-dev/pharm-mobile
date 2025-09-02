import 'dart:ui';

class AppSizes {
  final double p4;
  final double p6;
  final double p8;
  final double p10;
  final double p12;
  final double p16;
  final double p24;
  final double p32;
  final double p64;

  final double s2;
  final double s4;
  final double s6;
  final double s8;
  final double s12;
  final double s16;
  final double s24;
  final double s32;
  final double s48;
  final double s52;

  final double r4;
  final double r6;
  final double r8;
  final double r10;
  final double r12;
  final double r20;
  final double r30;
  final double r40;
  final double r60;
  final double r80;

  final double iconSize10;
  final double iconSize14;
  final double iconSize16;
  final double iconSize18;
  final double iconSize20;
  final double iconSize25;
  final double iconSize30;
  final double iconSize48;

  final double buttonHeight;
  final double commonWidgetsRadius;
  late final Map<String, double> _map;

  AppSizes({
    required this.p4,
    required this.p6,
    required this.p8,
    required this.p10,
    required this.p12,
    required this.p16,
    required this.p24,
    required this.p32,
    required this.p64,
    required this.s2,
    required this.s4,
    required this.s6,
    required this.s8,
    required this.s12,
    required this.s16,
    required this.s24,
    required this.s32,
    required this.s48,
    required this.s52,
    required this.r4,
    required this.r6,
    required this.r8,
    required this.r10,
    required this.r12,
    required this.r20,
    required this.r30,
    required this.r40,
    required this.r60,
    required this.r80,
    required this.iconSize10,
    required this.iconSize14,
    required this.iconSize16,
    required this.iconSize18,
    required this.iconSize20,
    required this.iconSize25,
    required this.iconSize30,
    required this.iconSize48,
    required this.buttonHeight,
    required this.commonWidgetsRadius,
  }) {
    _map = {
      "p4": p4,
      "p6": p6,
      "p8": p8,
      "p10": p10,
      "p12": p12,
      "p16": p16,
      "p24": p24,
      "p32": p32,
      "p64": p64,
      "s2": s2,
      "s4": s4,
      "s6": s6,
      "s8": s8,
      "s12": s12,
      "s16": s16,
      "s24": s24,
      "s32": s32,
      "s48": s48,
      "s52": s52,
      "r4": r4,
      "r6": r6,
      "r8": r8,
      "r10": r10,
      "r12": r12,
      "r20": r20,
      "r30": r30,
      "r40": r40,
      "r60": r60,
      "r80": r80,
      "iconSize10": iconSize10,
      "iconSize14": iconSize14,
      "iconSize16": iconSize16,
      "iconSize18": iconSize18,
      "iconSize20": iconSize20,
      "iconSize25": iconSize25,
      "iconSize30": iconSize30,
      "iconSize48": iconSize48,
      "buttonHeight": buttonHeight,
      "commonWidgetsRadius": commonWidgetsRadius,
    };
  }

  double operator [](String key) =>
      _map[key] ?? (throw ArgumentError('Invalid AppSizes key: $key'));

  static AppSizes lerp(AppSizes a, AppSizes b, double t) {
    return AppSizes(
      p4: lerpDouble(a.p4, b.p4, t)!,
      p6: lerpDouble(a.p6, b.p6, t)!,
      p8: lerpDouble(a.p8, b.p8, t)!,
      p10: lerpDouble(a.p10, b.p10, t)!,
      p12: lerpDouble(a.p12, b.p12, t)!,
      p16: lerpDouble(a.p16, b.p16, t)!,
      p24: lerpDouble(a.p24, b.p24, t)!,
      p32: lerpDouble(a.p32, b.p32, t)!,
      p64: lerpDouble(a.p64, b.p64, t)!,
      s2: lerpDouble(a.s2, b.s2, t)!,
      s4: lerpDouble(a.s4, b.s4, t)!,
      s6: lerpDouble(a.s6, b.s6, t)!,
      s8: lerpDouble(a.s8, b.s8, t)!,
      s12: lerpDouble(a.s12, b.s12, t)!,
      s16: lerpDouble(a.s16, b.s16, t)!,
      s24: lerpDouble(a.s24, b.s24, t)!,
      s32: lerpDouble(a.s32, b.s32, t)!,
      s48: lerpDouble(a.s48, b.s48, t)!,
      s52: lerpDouble(a.s52, b.s52, t)!,
      r4: lerpDouble(a.r4, b.r4, t)!,
      r6: lerpDouble(a.r6, b.r6, t)!,
      r8: lerpDouble(a.r8, b.r8, t)!,
      r10: lerpDouble(a.r10, b.r10, t)!,
      r12: lerpDouble(a.r12, b.r12, t)!,
      r20: lerpDouble(a.r20, b.r20, t)!,
      r30: lerpDouble(a.r30, b.r30, t)!,
      r40: lerpDouble(a.r40, b.r40, t)!,
      r60: lerpDouble(a.r60, b.r60, t)!,
      r80: lerpDouble(a.r80, b.r80, t)!,
      iconSize10: lerpDouble(a.iconSize10, b.iconSize10, t)!,
      iconSize14: lerpDouble(a.iconSize14, b.iconSize14, t)!,
      iconSize16: lerpDouble(a.iconSize16, b.iconSize16, t)!,
      iconSize18: lerpDouble(a.iconSize18, b.iconSize18, t)!,
      iconSize20: lerpDouble(a.iconSize20, b.iconSize20, t)!,
      iconSize25: lerpDouble(a.iconSize25, b.iconSize25, t)!,
      iconSize30: lerpDouble(a.iconSize30, b.iconSize30, t)!,
      iconSize48: lerpDouble(a.iconSize48, b.iconSize48, t)!,
      buttonHeight: lerpDouble(a.buttonHeight, b.buttonHeight, t)!,
      commonWidgetsRadius:
          lerpDouble(a.commonWidgetsRadius, b.commonWidgetsRadius, t)!,
    );
  }
}
