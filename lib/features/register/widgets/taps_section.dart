import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/constants.dart';
import '../../common/buttons/solid/primary_text_button.dart';

class TabsSection extends StatelessWidget {
  final int selectedTab;
  const TabsSection({
    super.key,
    this.selectedTab = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizesManager.p8),
      decoration: BoxDecoration(
        color: AppColors.bgDarken,
        border: Border.all(color: StrokeColors.normal.color, width: 1),
        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryTextButton(
              label: "Email",
              height: 32,
              labelColor: selectedTab == 0 ? TextColors.white.color : TextColors.ternary.color,
              onTap: () {},
              color: selectedTab == 0 ? AppColors.accent1Shade1 : AppColors.bgWhite,
            ),
          ),
          Gap(AppSizesManager.s8),
          Expanded(
            child: PrimaryTextButton(
              label: "Phone Number",
              height: 32,
              onTap: () {},
              labelColor: selectedTab == 1 ? TextColors.white.color : TextColors.ternary.color,
              color: selectedTab == 1 ? AppColors.accent1Shade1 : AppColors.bgWhite,
            ),
          ),
        ],
      ),
    );
  }
}
