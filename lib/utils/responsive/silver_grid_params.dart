import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';

double calculateMarketplaceAspectRatio(
    DeviceSizes deviceSize, Orientation orientation) {
  if (deviceSize.width < DeviceSizes.mediumMobile.width) {
    return 0.85;
  }

  if (deviceSize.width <= DeviceSizes.smallTablet.width) {
    return 2.5;
  }

  return 3.5;
  // final current = min(deviceSize.width, deviceSize.height);
  // final deviceMin =
  //     min(DeviceSizes.smallTablet.width, DeviceSizes.smallTablet.height);
  // final deviceMax =
  //     min(DeviceSizes.largeTablet.width, DeviceSizes.largeTablet.height);

  // final minRatio = 2.0;
  // final maxRatio = orientation == Orientation.portrait ? 3.5 : minRatio;

  // if (current <= deviceMin) return minRatio;
  // if (current >= deviceMax) return maxRatio;

  // final t = (current - deviceMin) / (deviceMax - deviceMin);
  // return minRatio + (maxRatio - minRatio) * t;
}

double calculateVendorItemsAspectRatio(
    DeviceSizes deviceSize, Orientation orientation) {
  if (deviceSize.width < DeviceSizes.mediumMobile.width) {
    return 0.85;
  }

  if (deviceSize.width <= DeviceSizes.smallTablet.width) {
    return 2.5;
  }

  return 3.5;

  // final current = min(deviceSize.width, deviceSize.height);
  // final deviceMin =
  //     min(DeviceSizes.smallTablet.width, DeviceSizes.smallTablet.height);
  // final deviceMax =
  //     min(DeviceSizes.largeTablet.width, DeviceSizes.largeTablet.height);

  // final minRatio = 2.0;
  // final maxRatio = orientation == Orientation.portrait ? 3.0 : 2.0;

  // if (current <= deviceMin) return minRatio;
  // if (current >= deviceMax) return maxRatio;

  // final t = (current - deviceMin) / (deviceMax - deviceMin);
  // return minRatio + (maxRatio - minRatio) * t;
}

double calculateAllAnnouncementsAspectRatio(
    DeviceSizes deviceSize, Orientation orientation) {
  if (deviceSize.width <= DeviceSizes.largeMobile.width) {
    return 0.85;
  }
  return 1.15;
}

double calculateFeaturesAnnouncementsAspectRatio(
    DeviceSizes deviceSize, Orientation orientation) {
  if (deviceSize.width < DeviceSizes.mediumMobile.width) {
    return 0.85;
  }

  return 2.5;
}

double calculateMarketplaceGridSpacing(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 4 : 10;

double calculateMarketplaceMainAxisSpacing(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 2 : 4;

int calculateMarketplaceCrossAxisCount(DeviceSizes deviceSize) =>
    deviceSize.width < DeviceSizes.mediumTablet.width ? 1 : 2;
