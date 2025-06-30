import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../config/theme/colors_manager.dart';

class EmptyListWidget extends StatelessWidget {
  final String emptyIllustrationPath;
  final VoidCallback? onRefresh;
  const EmptyListWidget({super.key, this.emptyIllustrationPath = DrawableAssetStrings.emptyListIcon, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          DrawableAssetStrings.emptyListIcon,
          height: 200,
          width: 200,
        ),
        const Gap(AppSizesManager.s12),
        Text("No Result found.",
            style: AppTypography.body2MediumStyle.copyWith(
              color: TextColors.ternary.color,
            )),
        if (onRefresh != null) ...[
          const Gap(AppSizesManager.s12),
          PrimaryTextButton(
            label: "Refresh",
            labelColor: AppColors.accent1Shade1,
            onTap: onRefresh,
            height: AppSizesManager.buttonHeight,
          )
        ]
      ],
    );
  }
}
