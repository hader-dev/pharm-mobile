import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import 'package:iconsax/iconsax.dart';

import '../base_icon_button.dart';

class SecondaryIconButton extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final bool isBordered;
  const SecondaryIconButton(
      {super.key, required this.icon, this.bgColor = Colors.transparent, this.isBordered = false});

  @override
  Widget build(BuildContext context) {
    return BaseIconButton(
      icon: Icon(Iconsax.arrow_right_2, color: Colors.white),
      bgColor: AppColors.accent1Shade1,
      onPressed: () {},
    );
  }
}
