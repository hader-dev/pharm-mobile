import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class VendorWidgetShimmer1 extends StatelessWidget {
  const VendorWidgetShimmer1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
            child: ShimmerHelper.generateShimmer(
              height: 50,
              width: 50,
              isCircular: true,
              radius: context.responsiveAppSizeTheme.current.r4,
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
                ShimmerHelper.generateShimmer(
                  height: 15,
                  width: 200,
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
                  )
                ]),
                const ResponsiveGap.s12(),
                ShimmerHelper.generateShimmer(height: 12, width: 50, radius: context.responsiveAppSizeTheme.current.r4),
              ],
            ),
          )
        ],
      ),
    );
  }
}
