import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, ReadContext;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/medicine_products.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/para_pharma.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/vendors.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../cubit/market_place_cubit.dart';

class MarketPlaceTabBarSection extends StatefulWidget {
  const MarketPlaceTabBarSection({super.key});

  @override
  State<MarketPlaceTabBarSection> createState() => MarketPlaceTabBarSectionState();
}

class MarketPlaceTabBarSectionState extends State<MarketPlaceTabBarSection> with TickerProviderStateMixin {
  late final Animation animation;
  static late final TabController tabsController;
  static late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5));
    animation =
        Tween<double>(begin: 0, end: 1).animate(animationController.drive(CurveTween(curve: Curves.easeInCubic)));
  }

  @override
  Widget build(BuildContext context) {
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
        AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return SizedBox(height: 55 * (1 - animation.value).toDouble(), child: child);
            },
            child: ColoredBox(
                color: Colors.white,
                child: BlocBuilder<MarketPlaceCubit, MarketPlaceState>(
                  builder: (context, state) {
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
                          context.read<MarketPlaceCubit>().changeTab(index, tabsController);
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
                                        state.pageIndex == tabs.indexOf(tabInfos)
                                            ? AppColors.accent1Shade1
                                            : Colors.grey,
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
                  },
                ))),
        Expanded(
          child: TabBarView(
            controller: tabsController,
            children: [ParaPharmaProductsPage(), MedicineProductsPage(), VendorsPage()],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    tabsController.dispose();
    super.dispose();
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
