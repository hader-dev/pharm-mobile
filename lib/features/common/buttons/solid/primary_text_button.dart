import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/buttons/base_button.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class PrimaryTextButton extends BaseButton {
  const PrimaryTextButton(
      {super.key,
      super.onTap,
      super.isLoading = false,
      super.padding = AppSizesManager.p10,
      required super.label,
      super.color,
      super.textOverflow,
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
      super.spalshColor});
}
