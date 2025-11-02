import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
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
      radiusValue: context.responsiveAppSizeTheme.current.r4,
      onTap: onTap,
      height: context.responsiveAppSizeTheme.current.buttonHeight,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      label: label,
    );
  }
}
