import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../../../common/spacers/responsive_gap.dart' show ResponsiveGap;

class OrderComplaintHeaderWidget extends StatelessWidget {
  const OrderComplaintHeaderWidget({super.key, required this.claim});

  final OrderClaimHeaderModel claim;

  @override
  Widget build(BuildContext context) {
    final status = OrderClaimStatus.values.firstWhere(
        (e) => e.id == claim.claimStatusId,
        orElse: () => OrderClaimStatus.pending);

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => RoutingManager.router
          .pushNamed(RoutingManager.orderComplaint, extra: {
        "orderId": claim.orderId,
        "itemId": claim.orderItemId,
        "complaintId": claim.id
      }),
      child: Container(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(186, 245, 245, 245),
          ),
          borderRadius:
              BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text.rich(
                  TextSpan(
                      text: '# ',
                      style: context.responsiveTextTheme.current.bodyXSmall
                          .copyWith(color: TextColors.ternary.color),
                      children: [
                        TextSpan(
                          text: claim.displayId,
                          style: context.responsiveTextTheme.current.bodyXSmall
                              .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: TextColors.ternary.color),
                        ),
                      ]),
                ),
                Spacer(),
                CustomChip(
                    label: OrderClaimStatus.getTranslatedStatus(status),
                    labelColor: status.color,
                    labelStyle: context.responsiveTextTheme.current.bodyXSmall
                        .copyWith(
                            fontWeight: context.responsiveTextTheme.current
                                .appFont.appFontBold,
                            color: status.color),
                    color: status.color.withAlpha(50)),
              ],
            ),
            Text.rich(
              TextSpan(
                text: claim.subject,
                style: context.responsiveTextTheme.current.headLine3SemiBold
                    .copyWith(color: TextColors.primary.color),
              ),
            ),
            const ResponsiveGap.s4(),
            Text.rich(
              TextSpan(
                  text: '${context.translation!.created} : ',
                  style: context.responsiveTextTheme.current.bodyXSmall
                      .copyWith(color: TextColors.ternary.color),
                  children: [
                    TextSpan(
                      text: claim.createdAt.format,
                      style: context.responsiveTextTheme.current.bodyXSmall
                          .copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: TextColors.ternary.color),
                    ),
                  ]),
            ),
            const ResponsiveGap.s4(),
            if (claim.updatedAt.isAfter(claim.createdAt))
              Text.rich(
                TextSpan(
                    text: '${context.translation!.last_update} : ',
                    style: context.responsiveTextTheme.current.bodyXSmall
                        .copyWith(color: TextColors.primary.color),
                    children: [
                      TextSpan(
                        text: claim.updatedAt.format,
                        style: context.responsiveTextTheme.current.bodyXSmall
                            .copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: TextColors.ternary.color),
                      ),
                    ]),
              )
          ],
        ),
      ),
    );
  }
}
