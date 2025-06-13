import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_text_button.dart';

class NavigationButtonsSection extends StatelessWidget {
  const NavigationButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: Row(
        children: [
          Expanded(
            child: PrimaryTextButton(
              label: "Cancel",
              labelColor: AppColors.accent1Shade1,
              onTap: () {},
              borderColor: AppColors.accent1Shade1,
            ),
          ),
          Gap(AppSizesManager.s8),
          Expanded(
            child: PrimaryTextButton(
              label: "Next",
              onTap: () {},
              color: AppColors.accent1Shade1,
            ),
          ),
        ],
      ),
    );
  }
}
