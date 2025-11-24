import 'package:flutter/material.dart';
import '../../../../config/theme/colors_manager.dart';

import '../base_icon_button.dart';

class SecondaryIconButton extends BaseIconButton {
  SecondaryIconButton(
      {super.key,
      required super.icon,
      super.bgColor = AppColors.accent1Shade1,
      super.isBordered = false,
      super.onPressed,
      super.borderColor = Colors.transparent});
}
