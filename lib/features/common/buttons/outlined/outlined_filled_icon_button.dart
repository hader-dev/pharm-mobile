import 'package:flutter/material.dart';

import '../base_icon_button.dart';

class OutlinedFilledIconButton extends BaseIconButton {
  const OutlinedFilledIconButton(
      {super.key,
      required super.icon,
      super.bgColor = Colors.transparent,
      super.isBordered = false,
      super.onPressed,
      super.borderColor = Colors.transparent});
}
