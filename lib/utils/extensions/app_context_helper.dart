import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/typography/theme_extension.dart';

import '../../config/language_config/resources/app_localizations.dart'
    show AppLocalizations;

extension BuildContextHelper on BuildContext {
  AppLocalizations? get translation => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  Locale get locale => Localizations.localeOf(this);

  TextDirection get textDirection =>
      locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  ResponsiveTextTheme get responsiveTextTheme =>
      Theme.of(this).extension<ResponsiveTextTheme>()!;

  DeviceSizes get deviceSize {
    final width = MediaQuery.of(this).size.width;

    if (width <= DeviceSizes.smallMobile.width) {
      return DeviceSizes.smallMobile;
    } else if (width <= DeviceSizes.mediumMobile.width) {
      return DeviceSizes.mediumMobile;
    } else if (width <= DeviceSizes.largeMobile.width) {
      return DeviceSizes.largeMobile;
    } else if (width <= DeviceSizes.smallTablet.width) {
      return DeviceSizes.smallTablet;
    } else if (width <= DeviceSizes.mediumTablet.width) {
      return DeviceSizes.mediumTablet;
    } else {
      return DeviceSizes.largeTablet;
    }
  }
}
