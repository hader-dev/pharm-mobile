import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/typography/app_typography.dart';
import 'package:hader_pharm_mobile/config/theme/typography/config/font_large.dart';
import 'package:hader_pharm_mobile/config/theme/typography/config/font_meduim.dart';
import 'package:hader_pharm_mobile/config/theme/typography/config/font_small.dart';
import 'package:hader_pharm_mobile/config/theme/typography/theme_extension.dart';

import '../../utils/constants.dart';
import 'colors_manager.dart';
import 'typography/typoghrapy_source.dart';

class LightTheme {
  late final ThemeData theme;

  LightTheme({required DeviceSizes deviceSize}) {
    theme = ThemeData(
      fontFamily: AppTypographySource.appFont,
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
      extensions: <ThemeExtension<dynamic>>[
        ResponsiveTextTheme(
            small: AppTypography(appFont: appFontSmall),
            medium: AppTypography(appFont: appFontMeduim),
            large: AppTypography(appFont: appFontLarge),
            deviceSize: deviceSize),
      ],
    );
  }
}
