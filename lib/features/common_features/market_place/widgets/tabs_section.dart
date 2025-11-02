import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/medicine_products.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/para_pharma.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/vendors.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class MarketPlaceTabBarSection extends StatefulWidget {
  const MarketPlaceTabBarSection({super.key});

  @override
  State<MarketPlaceTabBarSection> createState() =>
      _MarketPlaceTabBarSectionState();
}

class _MarketPlaceTabBarSectionState extends State<MarketPlaceTabBarSection>
    with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final List<String> tabs = [
      translation.para_pharma,
      translation.medicines,
      translation.vendors
    ];
    TextStyle tabTextStyle = context.responsiveTextTheme.current.body3Medium;

    return Column(
      children: [
        ColoredBox(
          color: AppColors.accent1Shade2,
          child: TabBar(
              indicatorColor: AppColors.bgWhite,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelStyle: tabTextStyle,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.bgWhite,
              unselectedLabelColor: AppColors.accent1Shade2Deemphasized,
              controller: tabsController,
              onTap: (index) {},
              tabs: tabs
                  .map(
                    (tabLabel) => Tab(
                      child: Text(tabLabel),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: TabBarView(
            controller: tabsController,
            children: [
              ParaPharmaProductsPage(),
              MedicineProductsPage(),
              VendorsPage()
            ],
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
