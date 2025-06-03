import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import 'package:iconsax/iconsax.dart';

import '../base_icon_button.dart';

class OutlinedFilledIconButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final bool isBordered;
  const OutlinedFilledIconButton(
      {super.key, required this.icon, this.bgColor = Colors.transparent, this.isBordered = false});

  @override
  Widget build(BuildContext context) {
    return BaseIconButton(
      icon: Icon(Iconsax.arrow_right_2, color: AppColors.accent1Shade1),
      isBordered: true,
      bgColor: AppColors.accent1Shade3,
      borderColor: AppColors.accent1Shade1,
      onPressed: () {},
    );
  }
}
