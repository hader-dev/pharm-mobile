import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../base_button.dart';

class OutLinedTextButton extends BaseButton {
 const OutLinedTextButton({
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
