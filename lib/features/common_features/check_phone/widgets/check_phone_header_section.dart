import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';

class CheckEmailHeaderSection extends StatelessWidget {
  const CheckEmailHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Gap(AppSizesManager.s24),
          Text(
            'Check your phone',
            style: context.responsiveTextTheme.current.headLine1.copyWith(
                fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Please enter  the code we just sent to',
            style: context.responsiveTextTheme.current.body3Regular
                .copyWith(color: TextColors.ternary.color),
          ),
          Gap(AppSizesManager.s4),
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
