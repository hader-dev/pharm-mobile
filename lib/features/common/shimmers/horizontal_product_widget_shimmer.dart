import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class HorizontalProductWidgetShimmer extends StatelessWidget {
  const HorizontalProductWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p4,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8, vertical: context.responsiveAppSizeTheme.current.p12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              ShimmerHelper.generateShimmer(
                height: 25,
                width: 25,
                radius: context.responsiveAppSizeTheme.current.r4,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
                height: 130,
                width: 130,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.responsiveAppSizeTheme.current.p8,
                    horizontal: context.responsiveAppSizeTheme.current.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const ResponsiveGap.s8(),
                    Padding(
                      padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
                      child: ShimmerHelper.generateShimmer(
                        height: 15,
                        width: 100,
                        radius: context.responsiveAppSizeTheme.current.r4,
                      ),
                    ),
                    const ResponsiveGap.s8(),
                    ShimmerHelper.generateShimmer(
                        height: 12, width: 50, radius: context.responsiveAppSizeTheme.current.r4),
                    const ResponsiveGap.s12(),
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
