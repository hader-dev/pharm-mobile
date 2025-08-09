import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class ItemContent extends StatelessWidget {
  const ItemContent({
    super.key,
    required this.quantity,
    required this.price,
    required this.itemId,
    required this.orderId,
  });

  final int quantity;
  final String price;
  final String itemId;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.body3MediumStyle
              .copyWith(color: Colors.grey[500]),
          TextSpan(
            text: "${context.translation!.quantity} ",
            children: <InlineSpan>[
              TextSpan(
                text: quantity.toString(),
                style: AppTypography.body3MediumStyle
                    .copyWith(color: TextColors.primary.color),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text.rich(
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: double.parse(price).formatAsPrice(),
            style: AppTypography.body3MediumStyle,
            children: <InlineSpan>[
              TextSpan(
                text:
                    ' ${RoutingManager.rootNavigatorKey.currentContext!.translation!.currency}',
                style: AppTypography.bodySmallStyle
                    .copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
