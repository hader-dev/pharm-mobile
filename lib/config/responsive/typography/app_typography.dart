import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/app_fonts.dart';

class AppTypography {
  final TextStyle headLine1;
  final TextStyle headLine2;
  final TextStyle headLine3SemiBold;
  final TextStyle headLine3Medium;
  final TextStyle headLine4SemiBold;
  final TextStyle headLine4Medium;
  final TextStyle headLine5SemiBold;
  final TextStyle headLine5Medium;
  final TextStyle body1Medium;
  final TextStyle body1Regular;
  final TextStyle body2Medium;
  final TextStyle body2Regular;
  final TextStyle body3Medium;
  final TextStyle body3Regular;
  final TextStyle bodySmall;
  final TextStyle bodyXSmall;

  final AppFonts appFont;

  /// Normal constructor (from AppFonts)
  AppTypography({required this.appFont})
      : headLine1 = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine1,
          fontWeight: appFont.appFontBold,
        ),
        headLine2 = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine2,
          fontWeight: appFont.appFontBold,
        ),
        headLine3SemiBold = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine3,
          fontWeight: appFont.appFontSemiBold,
        ),
        headLine3Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine3,
          fontWeight: appFont.appFontMedium,
        ),
        headLine4SemiBold = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine4,
          fontWeight: appFont.appFontSemiBold,
        ),
        headLine4Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine4,
          fontWeight: appFont.appFontMedium,
        ),
        headLine5SemiBold = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine5,
          fontWeight: appFont.appFontSemiBold,
        ),
        headLine5Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.headLine5,
          fontWeight: appFont.appFontMedium,
        ),
        body1Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body1,
          fontWeight: appFont.appFontMedium,
        ),
        body1Regular = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body1,
          fontWeight: appFont.appFontRegular,
        ),
        body2Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body2,
          fontWeight: appFont.appFontMedium,
        ),
        body2Regular = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body2,
          fontWeight: appFont.appFontRegular,
        ),
        body3Medium = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body3,
          fontWeight: appFont.appFontMedium,
        ),
        body3Regular = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.body3,
          fontWeight: appFont.appFontRegular,
        ),
        bodySmall = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.bodySmall,
          fontWeight: appFont.appFontRegular,
        ),
        bodyXSmall = TextStyle(
          fontFamily: appFont.appFont,
          fontSize: appFont.bodyXSmall,
          fontWeight: appFont.appFontRegular,
        );

  const AppTypography._({
    required this.appFont,
    required this.headLine1,
    required this.headLine2,
    required this.headLine3SemiBold,
    required this.headLine3Medium,
    required this.headLine4SemiBold,
    required this.headLine4Medium,
    required this.headLine5SemiBold,
    required this.headLine5Medium,
    required this.body1Medium,
    required this.body1Regular,
    required this.body2Medium,
    required this.body2Regular,
    required this.body3Medium,
    required this.body3Regular,
    required this.bodySmall,
    required this.bodyXSmall,
  });

  AppTypography copyWith({
    TextStyle? headLine1,
    TextStyle? headLine2,
    TextStyle? headLine3SemiBold,
    TextStyle? headLine3Medium,
    TextStyle? headLine4SemiBold,
    TextStyle? headLine4Medium,
    TextStyle? headLine5SemiBold,
    TextStyle? headLine5Medium,
    TextStyle? body1Medium,
    TextStyle? body1Regular,
    TextStyle? body2Medium,
    TextStyle? body2Regular,
    TextStyle? body3Medium,
    TextStyle? body3Regular,
    TextStyle? bodySmall,
    TextStyle? bodyXSmall,
  }) {
    return AppTypography._(
      appFont: appFont,
      headLine1: headLine1 ?? this.headLine1,
      headLine2: headLine2 ?? this.headLine2,
      headLine3SemiBold: headLine3SemiBold ?? this.headLine3SemiBold,
      headLine3Medium: headLine3Medium ?? this.headLine3Medium,
      headLine4SemiBold: headLine4SemiBold ?? this.headLine4SemiBold,
      headLine4Medium: headLine4Medium ?? this.headLine4Medium,
      headLine5SemiBold: headLine5SemiBold ?? this.headLine5SemiBold,
      headLine5Medium: headLine5Medium ?? this.headLine5Medium,
      body1Medium: body1Medium ?? this.body1Medium,
      body1Regular: body1Regular ?? this.body1Regular,
      body2Medium: body2Medium ?? this.body2Medium,
      body2Regular: body2Regular ?? this.body2Regular,
      body3Medium: body3Medium ?? this.body3Medium,
      body3Regular: body3Regular ?? this.body3Regular,
      bodySmall: bodySmall ?? this.bodySmall,
      bodyXSmall: bodyXSmall ?? this.bodyXSmall,
    );
  }

  static AppTypography lerp(AppTypography a, AppTypography b, double t) {
    return AppTypography._(
      appFont: a.appFont,
      headLine1: TextStyle.lerp(a.headLine1, b.headLine1, t)!,
      headLine2: TextStyle.lerp(a.headLine2, b.headLine2, t)!,
      headLine3SemiBold:
          TextStyle.lerp(a.headLine3SemiBold, b.headLine3SemiBold, t)!,
      headLine3Medium: TextStyle.lerp(a.headLine3Medium, b.headLine3Medium, t)!,
      headLine4SemiBold:
          TextStyle.lerp(a.headLine4SemiBold, b.headLine4SemiBold, t)!,
      headLine4Medium: TextStyle.lerp(a.headLine4Medium, b.headLine4Medium, t)!,
      headLine5SemiBold:
          TextStyle.lerp(a.headLine5SemiBold, b.headLine5SemiBold, t)!,
      headLine5Medium: TextStyle.lerp(a.headLine5Medium, b.headLine5Medium, t)!,
      body1Medium: TextStyle.lerp(a.body1Medium, b.body1Medium, t)!,
      body1Regular: TextStyle.lerp(a.body1Regular, b.body1Regular, t)!,
      body2Medium: TextStyle.lerp(a.body2Medium, b.body2Medium, t)!,
      body2Regular: TextStyle.lerp(a.body2Regular, b.body2Regular, t)!,
      body3Medium: TextStyle.lerp(a.body3Medium, b.body3Medium, t)!,
      body3Regular: TextStyle.lerp(a.body3Regular, b.body3Regular, t)!,
      bodySmall: TextStyle.lerp(a.bodySmall, b.bodySmall, t)!,
      bodyXSmall: TextStyle.lerp(a.bodyXSmall, b.bodyXSmall, t)!,
    );
  }
}
