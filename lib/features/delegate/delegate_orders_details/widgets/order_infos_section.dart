import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart' show TextColors;

class DelegateOrderInfosSection extends StatelessWidget {
  final String orderRef;
  final String createdAt;

  const DelegateOrderInfosSection({super.key, required this.orderRef, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p12, horizontal: context.responsiveAppSizeTheme.current.p4),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      ),
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p6, horizontal: context.responsiveAppSizeTheme.current.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order reference", style: context.responsiveTextTheme.current.headLine4SemiBold),
              const ResponsiveGap.s12(),
              Text.rich(TextSpan(
                text: orderRef,
                style: context.responsiveTextTheme.current.headLine5Medium.copyWith(color: TextColors.ternary.color),
              )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("created at", style: context.responsiveTextTheme.current.headLine4SemiBold),
              const ResponsiveGap.s12(),
              Text(createdAt,
                  style: context.responsiveTextTheme.current.body3Regular.copyWith(color: TextColors.ternary.color)),
            ],
          ),
        ],
      ),
    );
  }
}
