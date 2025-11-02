import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/base_button.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class OutLinedFilledTextButton extends StatelessWidget {
  const OutLinedFilledTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      color: AppColors.accent1Shade3,
      labelColor: AppColors.accent1Shade2,
      radiusValue: context.responsiveAppSizeTheme.current.r4,
      onTap: () {},
      borderColor: AppColors.accent1Shade2,
      isOutLined: true,
      height: context.responsiveAppSizeTheme.current.buttonHeight,
      leadingIcon: Iconsax.arrow_right_2,
      trailingIcon: Iconsax.arrow_right_2,
      label: 'Primary Text Button',
    );
  }
}
