import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';

import '../../../utils/constants.dart';

class ProfilePictureSetupHeaderSection extends StatelessWidget {
  const ProfilePictureSetupHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Gap(AppSizesManager.s24),
          Text(
            'you’re all set',
            style: AppTypography.headLine1Style.copyWith(fontSize: AppSizesManager.p24, color: AppColors.accent1Shade1),
          ),
          Gap(AppSizesManager.s8),
          Text(
            'Take a  minute to upload a profile picture',
            style: AppTypography.body3RegularStyle.copyWith(color: TextColors.ternary.color),
          ),
        ],
      ),
    );
  }
}
