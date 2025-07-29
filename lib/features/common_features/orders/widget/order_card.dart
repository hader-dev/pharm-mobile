import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';

import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';

import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';

class OrderCard extends StatelessWidget {
  final BaseOrderModel orderData;
  late final OrderStatus orderStatus;
  OrderCard({
    super.key,
    required this.orderData,
  }) {
    orderStatus = OrderStatus.values.firstWhere(
      (element) => element.id == orderData.status,
      orElse: () => OrderStatus.pending,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(RoutingManager.ordersDetailsScreen, extra: orderData.id);
      },
      child: Container(
        margin: const EdgeInsets.all(AppSizesManager.p12),
        padding: EdgeInsets.all(AppSizesManager.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
          border: Border.all(color: StrokeColors.normal.color, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    text: TextSpan(
                      text: "#",
                      style: AppTypography.headLine4SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
                      children: [
                        TextSpan(
                            text: " ${context.translation!.order}-${orderData.id.split("-").first}",
                            style: AppTypography.headLine4SemiBoldStyle.copyWith(color: Colors.black)),
                        TextSpan(
                          text: "\n (${orderData.createdAt.toLocal().formatYMD})",
                          style: AppTypography.bodyXSmallStyle.copyWith(
                            color: TextColors.ternary.color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(AppSizesManager.p6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(AppSizesManager.r6), topLeft: Radius.circular(AppSizesManager.r6)),
                    color: orderStatus.color.withAlpha(50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(OrderStatus.getTranslatedStatus(orderStatus),
                          style: AppTypography.bodySmallStyle
                              .copyWith(color: orderStatus.color, fontWeight: AppTypography.appFontSemiBold)),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(AppSizesManager.s8),
            InfoRow(
              label: context.translation!.vendor,
              dataValue: orderData.sellerCompanyName ?? "N/A",
              contentDirection: Axis.vertical,
            ),
            const Gap(AppSizesManager.s12),
            InfoRow(
              label: context.translation!.deliver_to,
              dataValue: orderData.deliveryAddress,
              contentDirection: Axis.vertical,
            ),
            const Gap(AppSizesManager.s12),
            Padding(
              padding: const EdgeInsets.only(right: AppSizesManager.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoRow(
                    label: context.translation!.total_ht_amount,
                    dataValue: orderData.totalAmountExclTax.formatAsPriceForPrint(),
                    contentDirection: Axis.vertical,
                  ),
                  InfoRow(
                    label: context.translation!.total_ttc_amount,
                    dataValue: orderData.totalAmountInclTax.formatAsPriceForPrint(),
                    contentDirection: Axis.vertical,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
