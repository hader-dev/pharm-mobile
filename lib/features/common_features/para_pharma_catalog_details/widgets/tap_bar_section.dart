import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/helpers/para_pharma_catalog_details_tab_data.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ProductDetailsTabBarSection extends StatefulWidget {
  const ProductDetailsTabBarSection({super.key});

  @override
  State<ProductDetailsTabBarSection> createState() =>
      _ProductDetailsTabBarSectionState();
}

class _ProductDetailsTabBarSectionState
    extends State<ProductDetailsTabBarSection> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = paraPharmaCatalogDetailsTabData(context);

    TextStyle tabTextStyle = context.responsiveTextTheme.current.body3Medium;

    return TabBar(
        indicatorColor: AppColors.accent1Shade2,
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelStyle: tabTextStyle,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.accent1Shade1,
        controller:
            BlocProvider.of<ParaPharmaDetailsCubit>(context).tabController,
        onTap: (index) {
          BlocProvider.of<ParaPharmaDetailsCubit>(context, listen: false)
              .changeTapIndex(index);
        },
        tabs: tabs
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
