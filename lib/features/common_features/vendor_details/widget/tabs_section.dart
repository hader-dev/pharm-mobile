import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../cubit/vendor_details_cubit.dart';
import '../subPages/about_vendor/about_vendor.dart';
import '../subPages/medicines/medicines.dart';
import '../subPages/para_pharma/para_pharma.dart';

// onCategoryTapped(String categoryName) {
//   Scrollable.ensureVisible(TabBArSection.sectionsKeys[categoryName]!.currentContext!,
//       duration: const Duration(seconds: 1), curve: Curves.easeInOut);
// }

class VandorDetailsTabBarSection extends StatefulWidget {
  final List<String> tabs = [
    "About",
    "Medicine",
    "Para-Pharma",
  ];
  VandorDetailsTabBarSection({super.key});

  @override
  State<VandorDetailsTabBarSection> createState() =>
      _VandorDetailsTabBarSectionState();
}

class _VandorDetailsTabBarSectionState extends State<VandorDetailsTabBarSection>
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

    return Padding(
      padding: const EdgeInsets.only(top: AppSizesManager.p16),
      child: Column(
        children: [
          TabBar(
              indicatorColor: AppColors.accent1Shade2,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              labelStyle: tabTextStyle,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              tabAlignment: TabAlignment.start,
              labelColor: AppColors.accent1Shade1,
              controller: tabsController,
              onTap: (index) {},
              tabs: widget.tabs
                  .map(
                    (tabLabel) => Tab(
                      child: Text(
                        tabLabel,
                      ),
                    ),
                  )
                  .toList()),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabsController,
              children: [
                VendorDetailsPage(
                    vendorData: BlocProvider.of<VendorDetailsCubit>(context)
                        .vendorData),
                MedicinesPage(),
                ParaPharmaPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
