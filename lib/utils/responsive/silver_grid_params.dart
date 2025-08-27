import 'package:hader_pharm_mobile/config/responsive/device_size.dart';

double calculateMarketplaceAspectRatio(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 1.5 : 0.85;

double calculateMarketplaceGridSpacing(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 4 : 10;

double calculateMarketplaceMainAxisSpacing(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 4 : 6;

int calculateMarketplaceCrossAxisCount(DeviceSizes deviceSize) =>
    deviceSize.width <= DeviceSizes.mediumTablet.width ? 1 : 2;
