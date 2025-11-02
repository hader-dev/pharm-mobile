import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'order_item_widget.dart';

class OrderItemsSection extends StatelessWidget {
  final List<OrderItem> orderItems;
  const OrderItemsSection({super.key, required this.orderItems});

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
                  children: orderItems
                      .map(
                        (OrderItem item) => OrderItemWidget(
                          item: item,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
