import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../../models/order_details.dart';
import '../../../../utils/enums.dart';

class TrackingStepWidget extends StatelessWidget {
  final OrderStatusHistory historyStep;
  final bool isFirst;
  final bool isLast;

  const TrackingStepWidget({
    super.key,
    required this.historyStep,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    OrderStatus orderStatus = OrderStatus.values.firstWhere(
        (OrderStatus element) => element.id == historyStep.orderStatusId);
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
                        size:
                            context.responsiveAppSizeTheme.current.iconSize30),
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
        const ResponsiveGap.s12(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                OrderStatus.getTranslatedStatus(orderStatus),
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
