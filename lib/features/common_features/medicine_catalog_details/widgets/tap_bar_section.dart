import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../../config/theme/colors_manager.dart';
import '../cubit/medicine_details_cubit.dart';
import '../medicine_catalog_details.dart';

// onCategoryTapped(String categoryName) {
//   Scrollable.ensureVisible(TabBArSection.sectionsKeys[categoryName]!.currentContext!,
//       duration: const Duration(seconds: 1), curve: Curves.easeInOut);
// }

class ProductDetailsTabBarSection extends StatefulWidget {
  const ProductDetailsTabBarSection({super.key});

  @override
  State<ProductDetailsTabBarSection> createState() => _ProductDetailsTabBarSectionState();
}

class _ProductDetailsTabBarSectionState extends State<ProductDetailsTabBarSection> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

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
        controller: BlocProvider.of<MedicineDetailsCubit>(context).tabController,
        onTap: (index) {
          BlocProvider.of<MedicineDetailsCubit>(context, listen: false).changeTapIndex(index);
        },
        tabs: MedicineCatalogDetailsScreen.tabs
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
