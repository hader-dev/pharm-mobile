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
import 'package:iconsax/iconsax.dart';

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
        GoRouter.of(context)
            .pushNamed(RoutingManager.ordersDetailsScreen, extra: orderData.id);
      },
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.all(context.responsiveAppSizeTheme.current.p6),
                color: orderStatus.color.withAlpha(50),
                alignment: Alignment.center,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    OrderStatus.getTranslatedStatus(orderStatus),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        context.responsiveTextTheme.current.bodySmall.copyWith(
                      color: orderStatus.color,
                      fontWeight: context
                          .responsiveTextTheme.current.appFont.appFontSemiBold,
                    ),
                  ),
                ),
              ),
              const ResponsiveGap.s8(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderData.displayId,
                      style: context
                          .responsiveTextTheme.current.headLine4SemiBold
                          .copyWith(color: Colors.black),
                    ),
                    const ResponsiveGap.s12(),
                    InfoRow(
                      icon: Iconsax.calendar,
                      dataValue: orderData.createdAt.toLocal().formatYMD,
                      iconColor: AppColors.accent1Shade1,
                      contentDirection: Axis.horizontal,
                    ),
                    InfoRow(
                      icon: Iconsax.shop,
                      dataValue: orderData.sellerCompanyName ?? "N/A",
                      iconColor: AppColors.accent1Shade1,
                      contentDirection: Axis.horizontal,
                    ),
                    const ResponsiveGap.s4(),
                    InfoRow(
                      icon: Iconsax.location,
                      iconColor: AppColors.accent1Shade1,
                      dataValue: orderData.deliveryAddress,
                      contentDirection: Axis.horizontal,
                    ),
                    const ResponsiveGap.s4(),
                    InfoRow(
                      icon: Iconsax.coin,
                      iconColor: AppColors.accent1Shade1,
                      dataValue:
                          "${orderData.totalAmountExclTax.formatAsPriceForPrint()} ${context.translation!.currency}",
                      contentDirection: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
