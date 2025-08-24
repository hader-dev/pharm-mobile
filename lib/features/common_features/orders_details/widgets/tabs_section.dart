import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/complaints/order_complaints_page.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_details.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/order_items.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderDetailsTabBarSection extends StatefulWidget {
  const OrderDetailsTabBarSection({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderDetailsTabBarSection> createState() =>
      _OrderDetailsTabBarSectionState();
}

class _OrderDetailsTabBarSectionState extends State<OrderDetailsTabBarSection>
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
      translation.order_items,
      translation.order_complaint
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
                        tabLabel,
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
              OrdersDetailsPage(
                orderId: widget.orderId,
              ),
              OrderDetailsItemsPage(),
              OrderItemsComplaintPage()
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
      case "Order Items":
        return context.translation!.order_items;
      case "Order Complaint":
        return context.translation!.order_complaint;
      default:
        return "Tab";
    }
  }
}
