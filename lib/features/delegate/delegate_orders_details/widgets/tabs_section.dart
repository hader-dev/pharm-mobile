import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_orders_details/sub_pages/order_overview.dart'
    show DelegateOrdersOverViewPage;

import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DelegateOrderDetailsTabBarSection extends StatefulWidget {
  const DelegateOrderDetailsTabBarSection({super.key, required this.orderId, this.isEditable = false});
  final String orderId;
  final bool isEditable;

  @override
  State<DelegateOrderDetailsTabBarSection> createState() => _DelegateOrderDetailsTabBarSectionState();
}

class _DelegateOrderDetailsTabBarSectionState extends State<DelegateOrderDetailsTabBarSection>
    with TickerProviderStateMixin {
  late final TabController tabsController;
  @override
  void initState() {
    super.initState();
    tabsController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final List<String> tabs = [
      translation.overview,
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
            ],
          ),
        ),
      ],
    );
  }
}
