import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/complaints/order_complaints_page.dart'
    show OrderItemsComplaintPage;

import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/sub_pages/order_overview.dart'
    show DelegateOrdersOverViewPage;

import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderDetailsTabBarSection extends StatefulWidget {
  const OrderDetailsTabBarSection({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailsTabBarSection> createState() => _OrderDetailsTabBarSectionState();
}

class _OrderDetailsTabBarSectionState extends State<OrderDetailsTabBarSection> with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final List<String> tabs = [translation.overview, translation.order_complaint];

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
                      child: Text(
                        tabLabel,
                      ),
                    ),
                  )
                  .toList()),
        ),
        Expanded(
          child: TabBarView(
            controller: tabsController,
            children: [
              DelegateOrdersOverViewPage(
                orderId: widget.orderId,
              ),
              OrderItemsComplaintPage()
            ],
          ),
        ),
      ],
    );
  }

  String getTabTranslation(String label) {
    switch (label) {
      case "Overview":
        return context.translation!.overview;

      case "Order Complaint":
        return context.translation!.order_complaint;
      default:
        return "Tab";
    }
  }
}
