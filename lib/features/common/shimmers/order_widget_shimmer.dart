import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

import '../spacers/responsive_gap.dart' show ResponsiveGap, s6;

class OrderWidgetShimmer extends StatelessWidget {
  const OrderWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ShimmerHelper.generateShimmer(width: 28, height: 140, radius: context.responsiveAppSizeTheme.current.r6),
          ResponsiveGap.s8(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerHelper.generateShimmer(width: 120, height: 16, radius: 4),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.grey.shade400,
                      size: context.responsiveAppSizeTheme.current.iconSize25,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ShimmerHelper.generateShimmer(width: 90, height: 14, radius: 4),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ShimmerHelper.generateShimmer(width: 60, height: 14, radius: 4),
                    ResponsiveGap.s12(),
                    ShimmerHelper.generateShimmer(width: 80, height: 14, radius: 4),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerHelper.generateShimmer(width: 60, height: 14, radius: 4),
                    ResponsiveGap.s12(),
                    ShimmerHelper.generateShimmer(width: 90, height: 14, radius: 4),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ShimmerHelper.generateShimmer(width: 90, height: 14, radius: 4),
                    ResponsiveGap.s12(),
                    ShimmerHelper.generateShimmer(width: 100, height: 14, radius: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
