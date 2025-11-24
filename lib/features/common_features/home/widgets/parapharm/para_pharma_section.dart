import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/app_layout/cubit/app_layout_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/home/widgets/parapharm/para_pharma_section_items.dart';
import 'package:hader_pharm_mobile/features/common/widgets/section_title.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/cubit/market_place_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/widgets/tabs_section.dart'
    show MarketPlaceTabBarSectionState;
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ParaPharmaSection extends StatelessWidget {
  const ParaPharmaSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: AppSizesManager.p16, horizontal: AppSizesManager.p8),
    this.minSectionHeight = 280,
  });
  final EdgeInsets padding;
  final double minSectionHeight;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            title: translation.para_pharma,
            iconPath: DrawableAssetStrings.newParaPharmsIcon,
            isSeeAllEnabled: true,
            onSeeAllTap: () {
              AppLayout.appLayoutScaffoldKey.currentContext!.read<AppLayoutCubit>().changePage(1);
              MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
                  .read<MarketPlaceCubit>()
                  .changeTab(0, MarketPlaceTabBarSectionState.tabsController);
            },
          ),
          ParaPharmaSectionItems(
            minSectionHeight: minSectionHeight,
          ),
        ],
      ),
    );
  }
}
