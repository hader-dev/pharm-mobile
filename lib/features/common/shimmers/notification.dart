import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class NotificationWidgetShimmer extends StatelessWidget {
  const NotificationWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.p12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerHelper.generateShimmer(
            width: 60,
            height: 60,
            isCircular: true,
          ),
          ResponsiveGap.s12(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerHelper.generateShimmer(
                  width: 180,
                  height: 16,
                  radius: 4,
                ),
                ResponsiveGap.s8(),
                ShimmerHelper.generateShimmer(
                  width: double.infinity,
                  height: 14,
                  radius: 4,
                ),
                ResponsiveGap.s6(),
                ShimmerHelper.generateShimmer(
                  width: 200,
                  height: 14,
                  radius: 4,
                ),
                ResponsiveGap.s12(),
                ShimmerHelper.generateShimmer(
                  width: 90,
                  height: 12,
                  radius: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
