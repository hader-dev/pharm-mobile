import 'package:flutter/material.dart';

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../models/order_details.dart';
import '../../../../utils/constants.dart';
import 'order_item_widget.dart';

class OrderItemsSection extends StatelessWidget {
  final List<OrderItem> orderItems; // List of OrderItem objects>
  const OrderItemsSection({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollContoller = ScrollController();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizesManager.p12,
        horizontal: AppSizesManager.p6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(TextSpan(text: 'order items', style: AppTypography.headLine4SemiBoldStyle, children: <InlineSpan>[
            TextSpan(
              text: ' (${orderItems.length})',
              style: AppTypography.headLine5MediumStyle.copyWith(
                color: Colors.grey.shade600,
              ),
            )
          ])),
          const SizedBox(height: 12),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 450,
            ),
            child: Scrollbar(
              controller: scrollContoller,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizesManager.p8),
                child: ListView(
                  controller: scrollContoller,
                  shrinkWrap: true,
                  children: orderItems
                      .map(
                        (OrderItem item) => OrderItemWidget(
                          productName: item.designation ?? "N/A",
                          quantity: item.quantity,
                          price: item.unitPriceHt.toString(),
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
