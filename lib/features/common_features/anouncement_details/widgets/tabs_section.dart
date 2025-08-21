import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/announcement/announcement_overview.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/medicine_products/medicine_products.dart';
import 'package:hader_pharm_mobile/features/common_features/anouncement_details/sub_pages/para_pharma/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class AnnouncementDetailsTabBarSection extends StatefulWidget {
  const AnnouncementDetailsTabBarSection({super.key});

  @override
  State<AnnouncementDetailsTabBarSection> createState() =>
      _AnnouncementDetailsTabBarSectionState();
}

class _AnnouncementDetailsTabBarSectionState
    extends State<AnnouncementDetailsTabBarSection>
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
      translation.overview,
      translation.medicines,
      translation.para_pharma,
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
                      child: Text(
                        getTabTranslation(
                          tabLabel,
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabsController,
            children: [
              AnnouncementOverviewPage(),
              MedicineProductsPage(),
              ParapharmaProductsPage(),
            ],
          ),
        ),
      ],
    );
  }

  getTabTranslation(String label) {
    switch (label) {
      case "Overview":
        return context.translation!.overview;
      case "Medicines":
        return context.translation!.medicines;
      case "Para-Pharma":
        return context.translation!.para_pharma;

      default:
        return "Tab";
    }
  }
}
