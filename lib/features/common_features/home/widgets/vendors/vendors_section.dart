import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart' show AppLayout;
import 'package:hader_pharm_mobile/features/common_features/home/widgets/vendors/vendors_section_items.dart';
import 'package:hader_pharm_mobile/features/common/widgets/section_title.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart' show MarketPlaceScreen;
import 'package:hader_pharm_mobile/features/common_features/market_place/widgets/tabs_section.dart'
    show MarketPlaceTabBarSectionState;
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../utils/assets_strings.dart' show DrawableAssetStrings;
import '../../../../app_layout/cubit/app_layout_cubit.dart';
import '../../../market_place/cubit/market_place_cubit.dart';

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
            onSeeAllTap: () {
              AppLayout.appLayoutScaffoldKey.currentContext!.read<AppLayoutCubit>().changePage(1);
              MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
                  .read<MarketPlaceCubit>()
                  .changeTab(2, MarketPlaceTabBarSectionState.tabsController);
            },
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
