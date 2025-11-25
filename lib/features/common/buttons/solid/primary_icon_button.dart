import 'package:flutter/material.dart';

import '../../../../config/theme/colors_manager.dart';
import '../base_icon_button.dart';

class PrimaryIconButton extends BaseIconButton {
  const PrimaryIconButton(
      {super.key,
      required super.icon,
      super.bgColor = AppColors.accent1Shade2,
      super.isBordered = false,
      super.onPressed,
      super.onLongPressed,
      super.borderColor = Colors.transparent});
}
