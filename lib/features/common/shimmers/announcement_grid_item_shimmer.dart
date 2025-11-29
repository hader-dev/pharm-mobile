import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../utils/shimmer_helper.dart' show ShimmerHelper;

class AnnouncementGridItemWidgetShimmer extends StatelessWidget {
  const AnnouncementGridItemWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          child: ShimmerHelper.generateShimmer(
            width: double.maxFinite,
            height: 130,
            radius: context.responsiveAppSizeTheme.current.r12,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerHelper.generateShimmer(
                  width: 28,
                  height: 28,
                  radius: 50,
                  isCircular: true,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerHelper.generateShimmer(
                        width: 70,
                        height: 14,
                        radius: 4,
                      ),
                      const SizedBox(height: 6),
                      ShimmerHelper.generateShimmer(
                        width: 60,
                        height: 12,
                        radius: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
