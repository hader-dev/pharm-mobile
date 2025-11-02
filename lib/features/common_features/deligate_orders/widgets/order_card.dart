import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class OrderCard extends StatelessWidget {
  final BaseOrderModel orderData;
  late final OrderStatus orderStatus;
  final bool displayClientCompanyOrVendor;
  OrderCard(
      {super.key,
      required this.orderData,
      this.displayClientCompanyOrVendor = false}) {
    orderStatus = OrderStatus.values.firstWhere(
      (element) => element.id == orderData.status,
      orElse: () => OrderStatus.created,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(
            RoutingManager.deligateOrderDetailsScreen,
            extra: orderData.id);
      },
      child: Container(
        margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          border: Border.all(color: StrokeColors.normal.color, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    text: TextSpan(
                      text: "#",
                      style: context
                          .responsiveTextTheme.current.headLine4SemiBold
                          .copyWith(color: AppColors.accent1Shade1),
                      children: [
                        TextSpan(
                            text:
                                " ${context.translation!.order}-${orderData.id.split("-").first}",
                            style: context
                                .responsiveTextTheme.current.headLine4SemiBold
                                .copyWith(color: Colors.black)),
                        TextSpan(
                          text:
                              "\n (${orderData.createdAt.toLocal().formatYMD})",
                          style: context.responsiveTextTheme.current.bodyXSmall
                              .copyWith(
                            color: TextColors.ternary.color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const ResponsiveGap.s8(), // Small spacing
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                        context.responsiveAppSizeTheme.current.p6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(
                              context.responsiveAppSizeTheme.current.r6),
                          topLeft: Radius.circular(
                              context.responsiveAppSizeTheme.current.r6)),
                      color: orderStatus.color.withAlpha(50),
                    ),
                    child: Text(OrderStatus.getTranslatedStatus(orderStatus),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: context.responsiveTextTheme.current.bodySmall
                            .copyWith(
                                color: orderStatus.color,
                                fontWeight: context.responsiveTextTheme.current
                                    .appFont.appFontSemiBold)),
                  ),
                ),
              ],
            ),
            const ResponsiveGap.s8(),
            InfoRow(
              label: displayClientCompanyOrVendor
                  ? context.translation!.client
                  : context.translation!.vendor,
              dataValue: (displayClientCompanyOrVendor
                      ? orderData.clientCompanyName
                      : orderData.sellerCompanyName) ??
                  "N/A",
              contentDirection: Axis.vertical,
            ),
            const ResponsiveGap.s12(),
            InfoRow(
              label: context.translation!.deliver_to,
              dataValue: orderData.deliveryAddress,
              contentDirection: Axis.vertical,
            ),
            const ResponsiveGap.s12(),
            Padding(
              padding: EdgeInsets.only(
                  right: context.responsiveAppSizeTheme.current.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InfoRow(
                      label: context.translation!.total_ht_amount,
                      dataValue:
                          orderData.totalAmountExclTax.formatAsPriceForPrint(),
                      contentDirection: Axis.vertical,
                    ),
                  ),
                  const ResponsiveGap.s8(), // Small spacing
                  Expanded(
                    child: InfoRow(
                      label: context.translation!.total_ttc_amount,
                      dataValue:
                          orderData.totalAmountInclTax.formatAsPriceForPrint(),
                      contentDirection: Axis.vertical,
                    ),
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
