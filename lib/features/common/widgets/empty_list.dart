import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';

class EmptyListWidget extends StatelessWidget {
  final String emptyIllustrationPath;
  final VoidCallback? onRefresh;
  const EmptyListWidget(
      {super.key,
      this.emptyIllustrationPath = DrawableAssetStrings.emptyListIcon,
      this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final availableWidth = constraints.maxWidth;
        
        // Cart context or very constrained space
        if (availableHeight < 250) {
          return Container(
            height: availableHeight < 200 ? availableHeight * 0.9 : 200,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  emptyIllustrationPath,
                  height: 80, // Compact but visible SVG
                  width: 80,
                ),
                const SizedBox(height: 8),
                Text("No items found",
                    textAlign: TextAlign.center,
                    style: context.responsiveTextTheme.current.body2Medium.copyWith(
                      color: TextColors.ternary.color,
                      fontSize: 14,
                    )),
                if (onRefresh != null) ...[
                  const SizedBox(height: 8),
                  Transform.scale(
                    scale: 0.9,
                    child: PrimaryTextButton(
                      label: "Refresh",
                      labelColor: AppColors.accent1Shade1,
                      onTap: onRefresh,
                      height: 36,
                    ),
                  )
                ]
              ],
            ),
          );
        }
        
        // Small screen layout
        if (availableWidth < 360) {
          return Container(
            height: (availableHeight * 0.9) < 180 ? (availableHeight * 0.9) : 180,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  emptyIllustrationPath,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 8),
                Text("No items found",
                    textAlign: TextAlign.center,
                    style: context.responsiveTextTheme.current.bodySmall.copyWith(
                      color: TextColors.ternary.color,
                    )),
                if (onRefresh != null) ...[
                  const SizedBox(height: 8),
                  Transform.scale(
                    scale: 0.8,
                    child: PrimaryTextButton(
                      label: "Refresh",
                      labelColor: AppColors.accent1Shade1,
                      onTap: onRefresh,
                      height: 32,
                    ),
                  )
                ]
              ],
            ),
          );
        }
        
        // Regular layout for larger screens
        final imageSize = availableHeight < 600 ? 120.0 : 200.0;
        
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                emptyIllustrationPath,
                height: imageSize,
                width: imageSize,
              ),
              const SizedBox(height: 16),
              Text("No items found",
                  textAlign: TextAlign.center,
                  style: context.responsiveTextTheme.current.body2Medium.copyWith(
                    color: TextColors.ternary.color,
                  )),
              if (onRefresh != null) ...[
                const SizedBox(height: 16),
                PrimaryTextButton(
                  label: "Refresh",
                  labelColor: AppColors.accent1Shade1,
                  onTap: onRefresh,
                  height: AppSizesManager.buttonHeight,
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
