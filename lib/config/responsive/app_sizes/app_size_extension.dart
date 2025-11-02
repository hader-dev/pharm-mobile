import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/app_size.dart';
import 'package:hader_pharm_mobile/config/responsive/app_sizes/config/app_size_extra_large.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';

class ResponsiveAppSizeTheme extends ThemeExtension<ResponsiveAppSizeTheme> {
  final AppSizes small;
  final AppSizes medium;
  final AppSizes large;
  DeviceSizes deviceSize;
  late final AppSizes current;

  ResponsiveAppSizeTheme({
    required this.small,
    required this.medium,
    required this.large,
    this.deviceSize = DeviceSizes.mediumMobile,
  }) {
    current = currentDynamic;
  }

  @override
  ResponsiveAppSizeTheme copyWith({
    AppSizes? small,
    AppSizes? medium,
    AppSizes? large,
    DeviceSizes? deviceSize,
  }) {
    return ResponsiveAppSizeTheme(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      deviceSize: deviceSize ?? this.deviceSize,
    );
  }

  @override
  ResponsiveAppSizeTheme lerp(
    covariant ThemeExtension<ResponsiveAppSizeTheme>? other,
    double t,
  ) {
    if (other is! ResponsiveAppSizeTheme) return this;
    return ResponsiveAppSizeTheme(
      small: AppSizes.lerp(small, other.small, t),
      medium: AppSizes.lerp(medium, other.medium, t),
      large: AppSizes.lerp(large, other.large, t),
    );
  }

  AppSizes get currentDynamic {
    switch (deviceSize) {
      case DeviceSizes.smallMobile:
        return small;
      case DeviceSizes.mediumMobile:
        return medium;
      case DeviceSizes.largeMobile:
        return large;
      case DeviceSizes.smallTablet:
      case DeviceSizes.mediumTablet:
      case DeviceSizes.largeTablet:
        return appSizesExtraLarge;
    }
  }
}
