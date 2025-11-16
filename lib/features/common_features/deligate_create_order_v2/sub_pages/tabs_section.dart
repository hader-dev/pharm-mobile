import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/sub_pages/add_page.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/sub_pages/items_page.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderDeligateTabBarSection extends StatefulWidget {
  const OrderDeligateTabBarSection({super.key});

  @override
  State<OrderDeligateTabBarSection> createState() => _OrderDeligateTabBarSectionState();
}

class _OrderDeligateTabBarSectionState extends State<OrderDeligateTabBarSection> with TickerProviderStateMixin {
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
