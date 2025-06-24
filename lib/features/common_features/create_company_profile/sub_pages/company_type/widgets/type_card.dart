import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/theme/colors_manager.dart';
import '../../../../../../config/theme/typoghrapy_manager.dart';
import '../../../../../../utils/constants.dart';

class TypeCard extends StatelessWidget {
  final int selectedTypeIndex;
  final int index;
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const TypeCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
    required this.selectedTypeIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(AppSizesManager.p16),
        margin: const EdgeInsets.only(bottom: AppSizesManager.p16),
        decoration: BoxDecoration(
          color: selectedTypeIndex == index ? AppColors.accent1Shade3 : AppColors.bgWhite,
          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
          border: Border.all(
              color: selectedTypeIndex == index ? StrokeColors.focused.color : StrokeColors.normal.color,
              width: selectedTypeIndex == index ? 1 : 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTypography.headLine3SemiBoldStyle
                  .copyWith(color: selectedTypeIndex == index ? AppColors.accent1Shade1 : TextColors.primary.color),
            ),
            const SizedBox(height: 12),
            SvgPicture.asset(
              imagePath,
              height: 90,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
