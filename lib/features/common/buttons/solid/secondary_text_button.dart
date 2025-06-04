import 'package:flutter/material.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../base_button.dart';

class SecondaryTextButton extends StatelessWidget {
  final Color fillColor;
  final VoidCallback? onTap;
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const SecondaryTextButton({
    super.key,
    this.onTap,
    this.fillColor = AppColors.bgWhite,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      color: fillColor,
      radiusValue: AppSizesManager.r4,
      onTap: onTap,
      height: AppSizesManager.buttonHeight,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      label: label,
    );
  }
}
