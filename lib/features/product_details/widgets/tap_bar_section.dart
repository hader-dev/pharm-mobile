import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../config/theme/colors_manager.dart';

// onCategoryTapped(String categoryName) {
//   Scrollable.ensureVisible(TabBArSection.sectionsKeys[categoryName]!.currentContext!,
//       duration: const Duration(seconds: 1), curve: Curves.easeInOut);
// }

class ProductDetailsTabBarSection extends StatefulWidget {
  final List<String> tabs = ["Order Overview", "Product Details", "Documents"];
  ProductDetailsTabBarSection({super.key});
  // void generateSectionsKeys() {
  //   sectionsKeys = {for (var categoryItem in tabs.categories) categoryItem.category.name: GlobalKey()};
  // }

  @override
  State<ProductDetailsTabBarSection> createState() => _ProductDetailsTabBarSectionState();
}

class _ProductDetailsTabBarSectionState extends State<ProductDetailsTabBarSection> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TextStyle tabTextStyle = AppTypography.body3MediumStyle;

    return TabBar(
        indicatorColor: AppColors.accent1Shade2,
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelStyle: tabTextStyle,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.accent1Shade1,
        controller: TabController(length: 3, vsync: this),
        onTap: (index) {},
        tabs: widget.tabs
            .map(
              (tabLabel) => Tab(
                child: Text(
                  tabLabel,
                ),
              ),
            )
            .toList());
  }
}
