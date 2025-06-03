import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../base_button.dart';

class OutLinedTextButton extends StatelessWidget {
  const OutLinedTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      color: Colors.transparent,
      labelColor: AppColors.accent1Shade2,
      radiusValue: AppSizesManager.r4,
      onTap: () {},
      borderColor: AppColors.accent1Shade2,
      isOutLined: true,
      height: AppSizesManager.buttonHeight,
      leadingIcon: Iconsax.arrow_right_2,
      trailingIcon: Iconsax.arrow_right_2,
      label: 'Primary Text Button',
    );
  }
}
