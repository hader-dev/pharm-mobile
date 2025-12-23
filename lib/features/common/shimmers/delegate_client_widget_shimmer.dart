import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class DelegateClientWidgetShimmer extends StatelessWidget {
  const DelegateClientWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                child: ShimmerHelper.generateShimmer(
                  height: 60,
                  width: 60,
                  isCircular: true,
                  radius: context.responsiveAppSizeTheme.current.r4,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.responsiveAppSizeTheme.current.p6,
                    horizontal: context.responsiveAppSizeTheme.current.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerHelper.generateShimmer(
                      height: 15,
                      width: 200,
                      radius: context.responsiveAppSizeTheme.current.r4,
                    ),
                    const ResponsiveGap.s8(),
                    ShimmerHelper.generateShimmer(
                      height: 15,
                      width: 130,
                      radius: context.responsiveAppSizeTheme.current.r4,
                    ),
                    const ResponsiveGap.s8(),
                    ShimmerHelper.generateShimmer(
                      height: 15,
                      width: 150,
                      radius: context.responsiveAppSizeTheme.current.r4,
                    ),
                    const ResponsiveGap.s8(),
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
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              ShimmerHelper.generateShimmer(
                height: 20,
                width: 80,
                radius: context.responsiveAppSizeTheme.current.r4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
