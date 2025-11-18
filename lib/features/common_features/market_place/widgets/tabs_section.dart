import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/medicine_products.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/para_pharma.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/vendors.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MarketPlaceTabBarSection extends StatefulWidget {
  const MarketPlaceTabBarSection({super.key});

  @override
  State<MarketPlaceTabBarSection> createState() => _MarketPlaceTabBarSectionState();
}

class _MarketPlaceTabBarSectionState extends State<MarketPlaceTabBarSection> with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> tabIndex = ValueNotifier(0);
    final translation = context.translation!;
    final List<String> tasMapKeys = ['label', 'icon'];
    final List<Map<String, String>> tabs = [
      {tasMapKeys[0]: translation.para_pharma, tasMapKeys[1]: DrawableAssetStrings.newParaPharmsIcon},
      {tasMapKeys[0]: translation.medicines, tasMapKeys[1]: DrawableAssetStrings.newMedicinesIcon},
      {tasMapKeys[0]: translation.vendors, tasMapKeys[1]: DrawableAssetStrings.newSellerIcon}
    ];
    TextStyle tabTextStyle = context.responsiveTextTheme.current.body3Medium;

    return Column(
      children: [
        ColoredBox(
            color: Colors.white,
            child: ValueListenableBuilder<int>(
                valueListenable: tabIndex,
                builder: (context, index, child) {
                  return TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: true,
                      labelStyle: tabTextStyle,
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                      tabAlignment: TabAlignment.start,
                      indicatorColor: AppColors.accent1Shade1,
                      labelColor: AppColors.accent1Shade1,
                      unselectedLabelColor: Colors.grey,
                      controller: tabsController,
                      onTap: (index) {
                        tabIndex.value = index;
                      },
                      tabs: tabs
                          .map(
                            (tabInfos) => Tab(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    tabInfos[tasMapKeys[1]]!,
                                    height: context.responsiveAppSizeTheme.current.iconSize20,
                                    width: context.responsiveAppSizeTheme.current.iconSize20,
                                    colorFilter: ColorFilter.mode(
                                      tabIndex.value == tabs.indexOf(tabInfos) ? AppColors.accent1Shade1 : Colors.grey,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  ResponsiveGap.s4(),
                                  Text(tabInfos[tasMapKeys[0]]!, style: tabTextStyle),
                                ],
                              ),
                            ),
                          )
                          .toList());
                })),
        Expanded(
          child: TabBarView(
            controller: tabsController,
            children: [ParaPharmaProductsPage(), MedicineProductsPage(), VendorsPage()],
          ),
        ),
      ],
    );
  }

  String getTabTranslation(String label) {
    switch (label) {
      case "Medicines":
        return context.translation!.medicines;
      case "Para-Pharma":
        return context.translation!.para_pharma;
      case "Vendors":
        return context.translation!.vendors;

      default:
        return "Tab";
    }
  }
}
