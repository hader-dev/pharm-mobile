import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/check_out_item.dart' show CheckOutItemWidget;
import 'package:hader_pharm_mobile/models/cart_item.dart' show CartItemModel;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class CheckOutItemsSection extends StatelessWidget {
  final List<CartItemModel> items;
  const CheckOutItemsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p12,
        horizontal: context.responsiveAppSizeTheme.current.p6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      child: Scrollbar(
        child: Padding(
          padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: items
                .map(
                  (item) => CheckOutItemWidget(
                    item: item,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
