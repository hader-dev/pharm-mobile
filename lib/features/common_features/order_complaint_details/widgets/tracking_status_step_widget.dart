import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

class TrackingClaimStepWidget extends StatelessWidget {
  final ClaimStatusHistoryModel historyStep;
  final bool isFirst;
  final bool isLast;

  const TrackingClaimStepWidget({
    super.key,
    required this.historyStep,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    OrderClaimStatus orderStatus = OrderClaimStatus.values.firstWhere(
        (OrderClaimStatus element) => element.id == historyStep.claimStatusId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 20,
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  if (!isFirst)
                    Container(
                      height: 20,
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                  CircleAvatar(
                    child: Icon(orderStatus.icon,
                        color: orderStatus.color,
                        size: AppSizesManager.iconSize20),
                  ),
                  if (!isLast)
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.grey.shade300,
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                orderStatus.name,
                style: context.responsiveTextTheme.current.body3Medium,
              ),
              Text(
                historyStep.createdAt.toLocal().format,
                style: context.responsiveTextTheme.current.body3Regular,
              ),
              const ResponsiveGap.s4(),
              // Text(
              //   OrderStatus.translateDescription(context, orderStatus),
              //   style: const TextStyle(
              //     fontSize: AppTypography.appFontSize4,
              //     color: Colors.black54,
              //   ),
              // ),
              const ResponsiveGap.s24(),
            ],
          ),
        ),
      ],
    );
  }
}
