import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';

class CheckEmailHeaderSection extends StatelessWidget {
  const CheckEmailHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          const ResponsiveGap.s24(),
          Text(
            'Check your phone',
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: context.responsiveAppSizeTheme.current.p24,
                color: AppColors.accent1Shade1),
          ),
          const ResponsiveGap.s8(),
          Text(
            'Please enter  the code we just sent to',
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
          const ResponsiveGap.s4(),
          Text(
            '(+213) 776 50 70 86',
            style: context.responsiveTextTheme.current.body3Medium
                .copyWith(color: TextColors.primary.color),
          ),
        ],
      ),
    );
  }
}
