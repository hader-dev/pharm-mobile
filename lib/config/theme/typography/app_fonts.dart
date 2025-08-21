import 'package:flutter/material.dart';

class AppFonts {
  // Font family
  final String appFont;

  // Font Weights
  final FontWeight appFontBold;
  final FontWeight appFontSemiBold;
  final FontWeight appFontMedium;
  final FontWeight appFontRegular;

  // Font Sizes
  final double headLine1;
  final double headLine2;
  final double headLine3;
  final double headLine4;
  final double headLine5;

  final double body1;
  final double body2;
  final double body3;
  final double bodySmall;
  final double bodyXSmall;
  final double bodyXXSmall;

  const AppFonts({
    required this.appFont,
    required this.appFontBold,
    required this.appFontSemiBold,
    required this.appFontMedium,
    required this.appFontRegular,
    required this.headLine1,
    required this.headLine2,
    required this.headLine3,
    required this.headLine4,
    required this.headLine5,
    required this.body1,
    required this.body2,
    required this.body3,
    required this.bodySmall,
    required this.bodyXSmall,
    required this.bodyXXSmall,
  });

  AppFonts copyWith({
    String? appFont,
    FontWeight? appFontBold,
    FontWeight? appFontSemiBold,
    FontWeight? appFontMedium,
    FontWeight? appFontRegular,
    double? headLine1,
    double? headLine2,
    double? headLine3,
    double? headLine4,
    double? headLine5,
    double? body1,
    double? body2,
    double? body3,
    double? bodySmall,
    double? bodyXSmall,
    double? bodyXXSmall,
  }) {
    return AppFonts(
      appFont: appFont ?? this.appFont,
      appFontBold: appFontBold ?? this.appFontBold,
      appFontSemiBold: appFontSemiBold ?? this.appFontSemiBold,
      appFontMedium: appFontMedium ?? this.appFontMedium,
      appFontRegular: appFontRegular ?? this.appFontRegular,
      headLine1: headLine1 ?? this.headLine1,
      headLine2: headLine2 ?? this.headLine2,
      headLine3: headLine3 ?? this.headLine3,
      headLine4: headLine4 ?? this.headLine4,
      headLine5: headLine5 ?? this.headLine5,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      body3: body3 ?? this.body3,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyXSmall: bodyXSmall ?? this.bodyXSmall,
      bodyXXSmall: bodyXXSmall ?? this.bodyXXSmall,
    );
  }
}
