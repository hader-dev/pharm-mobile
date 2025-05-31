import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class DarkTheme {
  ThemeData theme = ThemeData(
      fontFamily: AppTypography.appFont,
      scaffoldBackgroundColor: AppColorsPallette.appLightBgColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColorsPallette.primaryColors.first),
      canvasColor: AppColorsPallette.appLightBgColor,
      primaryColor: AppColorsPallette.primaryColors.first,
      iconTheme: IconThemeData(color: AppColorsPallette.primaryColors.first, size: AppSizes.mediumIconSize),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontSize: AppTypography.appFontSize0, fontWeight: AppTypography.appFontBold),
        headlineMedium: TextStyle(fontSize: AppTypography.appFontSize1, fontWeight: AppTypography.appFontBold),
        headlineSmall: TextStyle(fontSize: AppTypography.appFontSize2, fontWeight: AppTypography.appFontBold),
        bodyMedium: TextStyle(
          fontSize: AppTypography.appFontSize3,
        ),
        bodySmall: TextStyle(
          fontSize: AppTypography.appFontSize4,
        ),
      ),
      tabBarTheme: TabBarThemeData(
          dividerHeight: 0.1,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          indicatorColor: AppColorsPallette.primaryColors.first,
          labelColor: AppColorsPallette.primaryColors.first,
          unselectedLabelColor: Colors.grey),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColorsPallette.lightAccentsColors.first));
}
