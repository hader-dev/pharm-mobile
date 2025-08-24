import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion_item.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

class OrderComplaintHeaderWidget extends StatelessWidget {
  const OrderComplaintHeaderWidget({super.key, required this.claim});

  final OrderClaimHeaderModel claim;

  @override
  Widget build(BuildContext context) {
    final status =
        OrderClaimStatus.values.firstWhere((e) => e.id == claim.claimStatusId);

    return InkAccordionItem(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: claim.subject,
              style: context.responsiveTextTheme.current.body1Medium.copyWith(
                  fontWeight:
                      context.responsiveTextTheme.current.appFont.appFontBold,
                  color: TextColors.primary.color),
            ),
          ),
          Text.rich(
            TextSpan(
              text: OrderClaimStatus.getTranslatedStatus(status),
              style: context.responsiveTextTheme.current.bodySmall.copyWith(
                  fontWeight:
                      context.responsiveTextTheme.current.appFont.appFontBold,
                  color: status.color),
            ),
          ),
        ],
      ),
      rawSubtitle: claim.createdAt.format,
      onTap: () => RoutingManager.router
          .pushNamed(RoutingManager.orderComplaint, extra: {
        "orderId": claim.orderId,
        "itemId": claim.orderItemId,
        "complaintId": claim.id
      }),
    );
  }
}
