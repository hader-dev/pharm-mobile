enum DeviceSizes {
  smallMobile,
  mediumMobile,
  largeMobile,
  smallTablet,
  mediumTablet,
  largeTablet,
}

extension DeviceSizesExtension on DeviceSizes {
  double get width {
    switch (this) {
      case DeviceSizes.smallMobile:
        return 320.0;
      case DeviceSizes.mediumMobile:
        return 375.0;
      case DeviceSizes.largeMobile:
        return 414.0;
      case DeviceSizes.smallTablet:
        return 768.0;
      case DeviceSizes.mediumTablet:
        return 834.0;
      case DeviceSizes.largeTablet:
        return 1024.0;
    }
  }

  double get height {
    switch (this) {
      case DeviceSizes.smallMobile:
        return 568.0;
      case DeviceSizes.mediumMobile:
        return 667.0;
      case DeviceSizes.largeMobile:
        return 736.0;
      case DeviceSizes.smallTablet:
        return 1024.0;
      case DeviceSizes.mediumTablet:
        return 1112.0;
      case DeviceSizes.largeTablet:
        return 1366.0;
    }
  }

  static DeviceSizes fromWidth(double width) {
    if (width < DeviceSizes.mediumMobile.width) {
      return DeviceSizes.smallMobile;
    } else if (width < DeviceSizes.largeMobile.width) {
      return DeviceSizes.mediumMobile;
    } else if (width < DeviceSizes.smallTablet.width) {
      return DeviceSizes.largeMobile;
    }else {
      return DeviceSizes.largeTablet;
    }
  }
}
