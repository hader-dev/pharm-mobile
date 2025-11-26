import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/shimmer_helper.dart' show ShimmerHelper;

class ComplaintShimmer extends StatelessWidget {
  const ComplaintShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerHelper.generateShimmer(
                  width: 120, height: 15, radius: context.responsiveAppSizeTheme.current.commonWidgetsRadius),
              ShimmerHelper.generateShimmer(
                width: 50,
                height: 26,
                radius: context.responsiveAppSizeTheme.current.commonWidgetsRadius,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ShimmerHelper.generateShimmer(
              width: 140, height: 15, radius: context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          const SizedBox(height: 10),
          ShimmerHelper.generateShimmer(
              width: 120, height: 15, radius: context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ],
      ),
    );
  }
}
