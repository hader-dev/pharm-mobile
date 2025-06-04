import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';

import '../../../utils/constants.dart';

class RegisterHeaderSection extends StatelessWidget {
  const RegisterHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Gap(AppSizesManager.s24),
          Text(
            'Create Account',
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Hi! Welcome back, you’ve been missed',
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
