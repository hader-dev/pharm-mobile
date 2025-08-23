import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../sub_pages/favorites_medicines_catalogs/favorites_medicines_catalogs.dart'
    show FavoritesMedicinesCatalog;
import '../sub_pages/favorites_para_pharma_catalogs/favorites_para_pharma_catalogs.dart'
    show FavoritesParaPharmaCatalogs;
import '../sub_pages/favorites_vendors/favorites_vendors.dart'
    show FavoritesVendors;

// onCategoryTapped(String categoryName) {
//   Scrollable.ensureVisible(TabBArSection.sectionsKeys[categoryName]!.currentContext!,
//       duration: const Duration(seconds: 1), curve: Curves.easeInOut);
// }

class FavoritesTabBarSection extends StatefulWidget {
  final List<String> tabs = ["Medicines", "Para-Pharma", "Vendors"];
  FavoritesTabBarSection({super.key});
  // void generateSectionsKeys() {
  //   sectionsKeys = {for (var categoryItem in tabs.categories) categoryItem.category.name: GlobalKey()};
  // }

  @override
  State<FavoritesTabBarSection> createState() => _FavoritesTabBarSectionState();
}

class _FavoritesTabBarSectionState extends State<FavoritesTabBarSection>
    with TickerProviderStateMixin {
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
        TabBar(
            indicatorColor: AppColors.bgWhite,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelStyle: tabTextStyle,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            tabAlignment: TabAlignment.start,
            unselectedLabelColor: AppColors.accent1Shade2Deemphasized,
            labelColor: AppColors.bgWhite,
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
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabsController,
            children: [
              FavoritesMedicinesCatalog(),
              FavoritesParaPharmaCatalogs(),
              FavoritesVendors()
            ],
          ),
        ),
      ],
    );
  }

  getTabTranslation(String label) {
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
