import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_orders_details/sub_pages/order_items/widgets/order_item_widget_editable.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'order_item_widget_view.dart';

class OrderItemsSection extends StatelessWidget {
  final List<DeligateOrderItemUi> orderItems;
  final bool canEdit;
  const OrderItemsSection(
      {super.key, required this.orderItems, required this.canEdit});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollContoller = ScrollController();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p12,
        horizontal: context.responsiveAppSizeTheme.current.p6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(TextSpan(
              text: context.translation!.order_items,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
              children: <InlineSpan>[
                TextSpan(
                  text: ' (${orderItems.length})',
                  style: context.responsiveTextTheme.current.headLine5Medium
                      .copyWith(
                    color: Colors.grey.shade600,
                  ),
                )
              ])),
          const ResponsiveGap.s12(),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 450,
            ),
            child: Scrollbar(
              controller: scrollContoller,
              child: Padding(
                padding: EdgeInsets.only(
                    right: context.responsiveAppSizeTheme.current.p8),
                child: ListView(
                  controller: scrollContoller,
                  shrinkWrap: true,
                  children: itemBuilderView(orderItems, canEdit),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> itemBuilderView(List<DeligateOrderItemUi> orderItems,
      [bool canEdit = false]) {
    return orderItems
        .map(
          (DeligateOrderItemUi item) => canEdit
              ? OrderItemEditable(
                  item: item,
                )
              : OrderItemWidget(
                  item: item,
                ),
        )
        .toList();
  }
}
