import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/app_size_extension.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/config/app_size_large.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/config/app_size_medium.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/config/app_size_small.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/app_typography.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/config/font_extra_large.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/config/font_large.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/config/font_meduim.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/config/font_small.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/theme_extension.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../responsive/typography/typoghrapy_source.dart';
import 'colors_manager.dart';

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
            extraLarge: AppTypography(appFont: appFontExtraLarge),
            deviceSize: deviceSize),
        ResponsiveAppSizeTheme(
            small: appSizesSmall,
            medium: appSizesMedium,
            large: appSizesLarge,
            deviceSize: deviceSize),
      ],
    );
  }
}
