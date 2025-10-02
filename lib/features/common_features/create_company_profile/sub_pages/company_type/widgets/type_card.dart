import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class TypeCard extends StatelessWidget {
  final int selectedTypeIndex;
  final int index;
  final String title;
  final String? subtitle;
  final String imagePath;
  final VoidCallback? onTap;

  const TypeCard({
    super.key,
    required this.title,
    this.subtitle,
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
          color: selectedTypeIndex == index
              ? AppColors.accent1Shade3
              : AppColors.bgWhite,
          borderRadius:
              BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
          border: Border.all(
              color: selectedTypeIndex == index
                  ? StrokeColors.focused.color
                  : StrokeColors.normal.color,
              width: selectedTypeIndex == index ? 1 : 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(
                      color: selectedTypeIndex == index
                          ? AppColors.accent1Shade1
                          : TextColors.primary.color),
            ),
            const ResponsiveGap.s12(),
            SvgPicture.asset(
              imagePath,
              height: 90,
              fit: BoxFit.contain,
            ),
            const ResponsiveGap.s12(),
            if (subtitle != null)
              Text(
                subtitle!,
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(
                        color: selectedTypeIndex == index
                            ? AppColors.accent1Shade1
                            : TextColors.primary.color),
              ),
          ],
        ),
      ),
    );
  }
}
