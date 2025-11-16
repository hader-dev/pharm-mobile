import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/sub_pages/favorites_medicines_catalogs/favorites_medicines_catalogs.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/sub_pages/favorites_para_pharma_catalogs/favorites_para_pharma_catalogs.dart';
import 'package:hader_pharm_mobile/features/common_features/favorites/sub_pages/favorites_vendors/favorites_vendors.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FavoritesTabBarSection extends StatefulWidget {
  final List<String> tabs = ["Medicines", "Para-Pharma", "Vendors"];
  FavoritesTabBarSection({super.key});

  @override
  State<FavoritesTabBarSection> createState() => _FavoritesTabBarSectionState();
}

class _FavoritesTabBarSectionState extends State<FavoritesTabBarSection> with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabTextStyle = context.responsiveTextTheme.current.body3Medium;

    return Column(
      children: [
        ColoredBox(
          color: AppColors.bgWhite,
          child: TabBar(
              indicatorColor: AppColors.accent1Shade1,
              labelColor: AppColors.accent1Shade1,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelStyle: tabTextStyle,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabAlignment: TabAlignment.start,
              controller: tabsController,
              onTap: (index) {},
              tabs: widget.tabs
                  .map(
                    (tabLabel) => Tab(
                      child: Text(
                        getTabTranslation(tabLabel),
                      ),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: TabBarView(
            controller: tabsController,
            children: [FavoritesMedicinesCatalog(), FavoritesParaPharmaCatalogs(), FavoritesVendors()],
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
