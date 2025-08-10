import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'colors_manager.dart';
import 'typoghrapy_manager.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    fontFamily: AppTypography.appFont,
    scaffoldBackgroundColor: AppColors.bgWhite,
    canvasColor: AppColors.bgWhite,
    primaryColor: AppColors.accent1Shade1,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accentGreenShade1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent1Shade1,
      ),
    ),
    iconTheme: IconThemeData(size: AppSizesManager.iconSize20),


    // tabBarTheme: TabBarThemeData(
    //     dividerHeight: 0.1,
    //     overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    //     indicatorColor: AppColorsManager.primaryColors.first,
    //     labelColor: AppColorsManager.primaryColors.first,
    //     unselectedLabelColor: Colors.grey),
    // bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColorsManager.lightAccentsColors.first)
  );
}
