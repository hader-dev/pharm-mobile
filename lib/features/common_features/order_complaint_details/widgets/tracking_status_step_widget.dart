import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/order_claim.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

import '../../../../config/theme/colors_manager.dart' show TextColors;

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
    OrderClaimStatus orderClaimStatus =
        OrderClaimStatus.values.firstWhere((OrderClaimStatus element) => element.id == historyStep.claimStatusId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: context.responsiveAppSizeTheme.current.iconSize25,
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
                    backgroundColor: orderClaimStatus.color.withAlpha(50),
                    child: Icon(orderClaimStatus.icon,
                        color: orderClaimStatus.color, size: context.responsiveAppSizeTheme.current.iconSize20),
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
                OrderClaimStatus.getTranslatedStatus(orderClaimStatus),
                style: context.responsiveTextTheme.current.body3Medium,
              ),
              Text(
                historyStep.createdAt.format,
                style: context.responsiveTextTheme.current.bodyXSmall.copyWith(color: TextColors.ternary.color),
              ),
              const ResponsiveGap.s24(),
            ],
          ),
        ),
      ],
    );
  }
}
