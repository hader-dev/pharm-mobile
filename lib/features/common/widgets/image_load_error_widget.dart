import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ImageLoadErrorWidget extends StatelessWidget {
  final double iconSize;
  const ImageLoadErrorWidget(
      {super.key, this.iconSize = AppSizesManager.iconSize20});

  @override
  Widget build(BuildContext context) {
    return Icon(
      LucideIcons.image,
      size: iconSize,
      color: AppColors.accentGreenShade1.withAlpha(80),
    );
  }
}
