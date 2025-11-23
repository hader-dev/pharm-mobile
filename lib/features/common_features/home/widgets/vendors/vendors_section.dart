import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section_items.dart';
import 'package:hader_pharm_mobile/features/common/widgets/section_title.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../utils/assets_strings.dart' show DrawableAssetStrings;

class VendorSection extends StatelessWidget {
  const VendorSection({
    super.key,
    this.minSectionHeight = 110,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
  });
  final EdgeInsets padding;
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final screenWidth = MediaQuery.of(context).size.width;

    final maxItemsCount = context.deviceSize.width <= DeviceSizes.largeMobile.width ? 3 : 6;
    final maxItemsPerRow = context.deviceSize.width <= DeviceSizes.largeMobile.width ? 3 : 4;

    Widget content = Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(screenWidth <= 414 ? 0 : context.responsiveAppSizeTheme.current.s4),
          SectionTitle(
            title: translation.vendors,
            iconPath: DrawableAssetStrings.newSellerIcon,
            isSeeAllEnabled: true,
          ),
          VendorsSectionItems(
            maxItemsPerRow: maxItemsPerRow,
            maxVisibleItems: maxItemsCount,
            minSectionHeight: minSectionHeight,
          ),
        ],
      ),
    );

    if (screenWidth < 360) {
      return SizedBox(
        height: context.deviceSize.width <= DeviceSizes.largeMobile.width ? 120 : 90,
        child: ClipRect(child: content),
      );
    }

    return content;
  }
}
