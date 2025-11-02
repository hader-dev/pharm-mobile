import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/product_selector.dart';

class DeligateOrderDetailsAddOrderItemsPage extends StatelessWidget {
  const DeligateOrderDetailsAddOrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            translation.product,
            style:
                context.responsiveTextTheme.current.headLine3Medium.copyWith(),
          ),
          const ResponsiveGap.s4(),
          const Expanded(child: OrderProductSelector()),
        ],
      ),
    );
  }
}
