import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
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
              const ResponsiveGap.s16(),
              Text(context.translation!.no_items_found,
                  textAlign: TextAlign.center,
                  style:
                      context.responsiveTextTheme.current.body2Medium.copyWith(
                    color: TextColors.ternary.color,
                  )),
              if (onRefresh != null) ...[
                const ResponsiveGap.s16(),
                PrimaryTextButton(
                  label: context.translation!.refresh,
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
