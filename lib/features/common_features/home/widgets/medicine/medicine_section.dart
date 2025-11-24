import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/widgets/section_title.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/widgets/tabs_section.dart'
    show MarketPlaceTabBarSectionState;
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../app_layout/cubit/app_layout_cubit.dart';
import '../../../market_place/cubit/market_place_cubit.dart';
import 'medicine_section_items.dart';

class MedicineSection extends StatelessWidget {
  const MedicineSection({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
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
            title: translation.medicines,
            iconPath: DrawableAssetStrings.newMedicinesIcon,
            isSeeAllEnabled: true,
            onSeeAllTap: () {
              AppLayout.appLayoutScaffoldKey.currentContext!.read<AppLayoutCubit>().changePage(1);
              MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
                  .read<MarketPlaceCubit>()
                  .changeTab(1, MarketPlaceTabBarSectionState.tabsController);
            },
          ),
          MedicinesSectionItems(minSectionHeight: minSectionHeight),
        ],
      ),
    );
  }
}
