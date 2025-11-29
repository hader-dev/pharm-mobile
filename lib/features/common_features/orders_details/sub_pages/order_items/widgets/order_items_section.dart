import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/widgets/order_item_widget_v2.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class OrderItemsSection extends StatelessWidget {
  final List<OrderItem> orderItems;
  const OrderItemsSection({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p12,
        horizontal: context.responsiveAppSizeTheme.current.p6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
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
                  style: context.responsiveTextTheme.current.headLine5Medium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                )
              ])),
          const ResponsiveGap.s12(),
          Padding(
            padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
            child: ListView(
              controller: scrollController,
              children: orderItems
                  .map(
                    (OrderItem item) => OrderItemWidgetV2(
                      item: item,
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
