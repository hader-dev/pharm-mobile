import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';

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
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Please enter  the code we just sent to',
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
          Gap(AppSizesManager.s4),
          Text(
            '(+213) 776 50 70 86',
            style: AppTypography.body3MediumStyle.copyWith(color: TextColors.primary.color),
          ),
        ],
      ),
    );
  }
}
