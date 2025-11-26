import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class VerticalProductWidgetShimmer extends StatelessWidget {
  const VerticalProductWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveAppSizeTheme.current.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: context.responsiveAppSizeTheme.current.p6,
                  vertical: context.responsiveAppSizeTheme.current.p6),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
              ),
              child: Stack(
                children: [
                  ShimmerHelper.generateShimmer(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      radius: context.responsiveAppSizeTheme.current.r4),
                  Row(
                    children: [
                      ShimmerHelper.generateShimmer(
                          height: 25, width: 80, radius: context.responsiveAppSizeTheme.current.r4),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                        child: ShimmerHelper.generateShimmer(
                          height: 25,
                          width: 25,
                          isCircular: true,
                          radius: context.responsiveAppSizeTheme.current.r4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.responsiveAppSizeTheme.current.p8,
                horizontal: context.responsiveAppSizeTheme.current.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShimmerHelper.generateShimmer(height: 27, width: 27, isCircular: true),
                    const ResponsiveGap.s4(),
                    ShimmerHelper.generateShimmer(
                      height: 15,
                      width: 100,
                      radius: context.responsiveAppSizeTheme.current.r4,
                    ),
                  ],
                ),
                const ResponsiveGap.s4(),
                Padding(
                  padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
                  child: ShimmerHelper.generateShimmer(
                    height: 15,
                    width: double.maxFinite,
                    radius: context.responsiveAppSizeTheme.current.r4,
                  ),
                ),
                const ResponsiveGap.s6(),
                Row(spacing: context.responsiveAppSizeTheme.current.p4, children: [
                  ShimmerHelper.generateShimmer(
                    height: 25,
                    width: 38,
                    radius: context.responsiveAppSizeTheme.current.r4,
                  ),
                  ShimmerHelper.generateShimmer(
                    height: 25,
                    width: 38,
                    radius: context.responsiveAppSizeTheme.current.r4,
                  )
                ]),
                const ResponsiveGap.s6(),
                ShimmerHelper.generateShimmer(height: 12, width: 50, radius: context.responsiveAppSizeTheme.current.r4),
                const ResponsiveGap.s12(),
                ShimmerHelper.generateShimmer(
                    height: context.responsiveAppSizeTheme.current.buttonHeight,
                    width: double.maxFinite,
                    radius: context.responsiveAppSizeTheme.current.r4),
              ],
            ),
          )
        ],
      ),
    );
  }
}
