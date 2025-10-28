import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/sub_pages/add_page.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/sub_pages/items_page.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderDeligateTabBarSection extends StatefulWidget {
  const OrderDeligateTabBarSection({super.key});

  @override
  State<OrderDeligateTabBarSection> createState() =>
      _OrderDeligateTabBarSectionState();
}

class _OrderDeligateTabBarSectionState extends State<OrderDeligateTabBarSection>
    with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final List<String> tabs = [
      translation.add_cart,
      translation.order_items,
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
        Flexible(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabsController,
            children: [
              const DeligateAddOrderItemsPage(),
              const DeligateOrderItemsPage(),
            ],
          ),
        ),
      ],
    );
  }
}
