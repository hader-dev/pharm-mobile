import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../base_button.dart';

class PrimaryTextButton extends BaseButton {
  PrimaryTextButton({
    super.key,
    super.onTap,
    super.isLoading = false,
    super.padding = AppSizesManager.p10,
    required super.label,
    super.color,
    super.labelColor = Colors.white,
    super.height = AppSizesManager.buttonHeight,
    super.loadingColor = Colors.white,
    super.minWidth = 100,
    super.radiusValue = AppSizesManager.commonWidgetsRadius,
    super.isRectangular = true,
    super.isOutLined = false,
    super.borderColor,
    super.leadingIcon,
    super.trailingIcon,
  });
}
