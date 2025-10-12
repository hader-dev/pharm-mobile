import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

class AppDivider extends Divider {
  const AppDivider({
    super.key,
    super.height,
    super.thickness,
    super.indent,
    super.endIndent,
    super.color,
    super.radius,
  });

  const AppDivider.tiny({Key? key})
      : this(
            key: key,
            color: AppColors.accent1Shade2Deemphasized,
            thickness: 0.2);
}
