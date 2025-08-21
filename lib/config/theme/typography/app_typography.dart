import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/typography/app_fonts.dart';

class AppTypography {
  final AppFonts appFont;

  AppTypography({required this.appFont}) {
    headLine1 = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine1,
      fontWeight: appFont.appFontBold,
    );
    headLine2 = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine2,
      fontWeight: appFont.appFontBold,
    );
    headLine3SemiBold = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine3,
      fontWeight: appFont.appFontSemiBold,
    );
    headLine3Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine3,
      fontWeight: appFont.appFontMedium,
    );
    headLine4SemiBold = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine4,
      fontWeight: appFont.appFontSemiBold,
    );
    headLine4Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine4,
      fontWeight: appFont.appFontMedium,
    );
    headLine5SemiBold = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine5,
      fontWeight: appFont.appFontSemiBold,
    );
    headLine5Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.headLine5,
      fontWeight: appFont.appFontMedium,
    );
    // Bodys Text Styles
    body1Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body1,
      fontWeight: appFont.appFontMedium,
    );
    body1Regular = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body1,
      fontWeight: appFont.appFontRegular,
    );
    body2Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body2,
      fontWeight: appFont.appFontMedium,
    );
    body2Regular = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body2,
      fontWeight: appFont.appFontRegular,
    );
    body3Medium = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body3,
      fontWeight: appFont.appFontMedium,
    );
    body3Regular = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.body3,
      fontWeight: appFont.appFontRegular,
    );
    bodySmall = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.bodySmall,
      fontWeight: appFont.appFontRegular,
    );
    bodyXSmall = TextStyle(
      fontFamily: appFont.appFont,
      fontSize: appFont.bodyXSmall,
      fontWeight: appFont.appFontRegular,
    );
  }

  late final TextStyle headLine1;

  late final TextStyle headLine2;

  late final TextStyle headLine3SemiBold;

  late final TextStyle headLine3Medium;

  late final TextStyle headLine4SemiBold;

  late final TextStyle headLine4Medium;

  late final TextStyle headLine5SemiBold;

  late final TextStyle headLine5Medium;

  late final TextStyle body1Medium;

  late final TextStyle body1Regular;

  late final TextStyle body2Medium;

  late final TextStyle body2Regular;

  late final TextStyle body3Medium;

  late final TextStyle body3Regular;

  late final TextStyle bodySmall;

  late final TextStyle bodyXSmall;

  static AppTypography lerp(AppTypography a, AppTypography b, double t) {
    return AppTypography(
      appFont: a.appFont, // font family + weights stay consistent
    )
      ..headLine1 = TextStyle.lerp(a.headLine1, b.headLine1, t)!
      ..headLine2 = TextStyle.lerp(a.headLine2, b.headLine2, t)!
      ..headLine3SemiBold =
          TextStyle.lerp(a.headLine3SemiBold, b.headLine3SemiBold, t)!
      ..headLine3Medium =
          TextStyle.lerp(a.headLine3Medium, b.headLine3Medium, t)!
      ..headLine4SemiBold =
          TextStyle.lerp(a.headLine4SemiBold, b.headLine4SemiBold, t)!
      ..headLine4Medium =
          TextStyle.lerp(a.headLine4Medium, b.headLine4Medium, t)!
      ..headLine5SemiBold =
          TextStyle.lerp(a.headLine5SemiBold, b.headLine5SemiBold, t)!
      ..headLine5Medium =
          TextStyle.lerp(a.headLine5Medium, b.headLine5Medium, t)!
      ..body1Medium = TextStyle.lerp(a.body1Medium, b.body1Medium, t)!
      ..body1Regular = TextStyle.lerp(a.body1Regular, b.body1Regular, t)!
      ..body2Medium = TextStyle.lerp(a.body2Medium, b.body2Medium, t)!
      ..body2Regular = TextStyle.lerp(a.body2Regular, b.body2Regular, t)!
      ..body3Medium = TextStyle.lerp(a.body3Medium, b.body3Medium, t)!
      ..body3Regular = TextStyle.lerp(a.body3Regular, b.body3Regular, t)!
      ..bodySmall = TextStyle.lerp(a.bodySmall, b.bodySmall, t)!
      ..bodyXSmall = TextStyle.lerp(a.bodyXSmall, b.bodyXSmall, t)!;
  }
}
