import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/app_typography.dart';

class ResponsiveTextTheme extends ThemeExtension<ResponsiveTextTheme> {
  final AppTypography small;
  final AppTypography medium;
  final AppTypography large;
  final AppTypography extraLarge;
  final AppTypography current;

  DeviceSizes deviceSize;

  ResponsiveTextTheme({
    required this.small,
    required this.current,
    required this.medium,
    required this.large,
    required this.extraLarge,
    this.deviceSize = DeviceSizes.mediumMobile,
  });

  @override
  ResponsiveTextTheme copyWith({
    AppTypography? small,
    AppTypography? medium,
    AppTypography? large,
    AppTypography? extraLarge,
    AppTypography? current,
    DeviceSizes? deviceSize,
  }) {
    return ResponsiveTextTheme(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      deviceSize: deviceSize ?? this.deviceSize,
      extraLarge: extraLarge ?? this.extraLarge,
      current: current ?? this.current,
    );
  }

  @override
  ResponsiveTextTheme lerp(
    covariant ThemeExtension<ResponsiveTextTheme>? other,
    double t,
  ) {
    if (other is! ResponsiveTextTheme) return this;
    return ResponsiveTextTheme(
      small: AppTypography.lerp(small, other.small, t),
      medium: AppTypography.lerp(medium, other.medium, t),
      large: AppTypography.lerp(large, other.large, t),
      extraLarge: AppTypography.lerp(extraLarge, other.extraLarge, t),
      current: AppTypography.lerp(current, other.current, t),
      deviceSize: other.deviceSize,
    );
  }
}

AppTypography decideTypography(DeviceSizes deviceSize, AppTypography small,
    AppTypography medium, AppTypography large, AppTypography extraLarge) {
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
      return extraLarge;
  }
}
