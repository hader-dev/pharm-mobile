import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/order.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

import '../../../common/widgets/info_row_column.dart' show RowColumnDataHolders, InfoRowColumn;

class DelegateOrderCard extends StatelessWidget {
  final BaseOrderModel orderData;
  late final OrderStatus orderStatus;
  final bool displayClientCompanyOrVendor;
  DelegateOrderCard({super.key, required this.orderData, this.displayClientCompanyOrVendor = false}) {
    orderStatus = OrderStatus.values.firstWhere(
      (element) => element.id == orderData.status,
      orElse: () => OrderStatus.created,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(RoutingManager.delegateOrderDetailsScreen, extra: orderData.id);
      },
      child: Container(
        margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(186, 245, 245, 245),
          ),
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                  color: orderStatus.color.withAlpha(50),
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      OrderStatus.getTranslatedStatus(orderStatus),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.responsiveTextTheme.current.bodySmall.copyWith(
                        color: orderStatus.color,
                        fontWeight: context.responsiveTextTheme.current.appFont.appFontSemiBold,
                      ),
                    ),
                  ),
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderData.displayId,
                                style:
                                    context.responsiveTextTheme.current.headLine4SemiBold.copyWith(color: Colors.black),
                              ),
                              const ResponsiveGap.s2(),
                              Text(orderData.createdAt.format,
                                  style: context.responsiveTextTheme.current.bodyXSmall
                                      .copyWith(color: TextColors.secondary.color)),
                              const ResponsiveGap.s8(),
                            ],
                          ),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: context.responsiveAppSizeTheme.current.s16, color: Colors.black),
                        ],
                      ),
                      const ResponsiveGap.s4(),
                      InfoRowColumn(
                        data: [
                          RowColumnDataHolders(
                            title: context.translation!.seller,
                            value: orderData.sellerCompanyName ?? "N/A",
                            titleStyle: context.responsiveTextTheme.current.body2Medium.copyWith(color: Colors.grey),
                            valueStyle: context.responsiveTextTheme.current.body2Medium,
                          ),
                          RowColumnDataHolders(
                            title: context.translation!.deliver_to,
                            value: orderData.deliveryAddress,
                            titleStyle: context.responsiveTextTheme.current.body2Medium.copyWith(color: Colors.grey),
                            valueStyle: context.responsiveTextTheme.current.body2Medium,
                          ),
                          RowColumnDataHolders(
                            title: context.translation!.total_amount,
                            value:
                                "${orderData.totalAppliedAmountTtc.formatAsPriceForPrint()} ${context.translation!.currency}",
                            titleStyle: context.responsiveTextTheme.current.body2Medium.copyWith(color: Colors.grey),
                            valueStyle: context.responsiveTextTheme.current.body2Medium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
