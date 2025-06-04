import 'package:flutter/material.dart';

import '../../../../config/theme/colors_manager.dart';
import '../base_icon_button.dart';

class OutlinedIconButton extends BaseIconButton {
  const OutlinedIconButton({
    super.key,
    required super.icon,
    super.bgColor = Colors.transparent,
    super.isBordered = true,
    super.onPressed,
    super.borderColor = AppColors.accent1Shade2,
  });
}
