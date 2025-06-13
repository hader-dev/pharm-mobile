import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Description',
          style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
        ),
        Gap(AppSizesManager.s12),
        Text(
          "Sint voluptate adipisicing deserunt culpa reprehenderit sint in do consectetur duis id eu. Occaecat officia do consectetur voluptate reprehenderit voluptate velit consectetur occaecat cupidatat nisi. Cupidatat ullamco aliqua magna qui eiusmod ad ex. Cillum non cupidatat irure excepteur veniam labore sit quis occaecat. Enim laborum proident id excepteur esse adipisicing laborum amet ex. Esse est adipisicing ad laboris duis ullamco tempor magna commodo excepteur et ea irure. Aliqua eu est qui amet velit culpa elit ea dolor adipisicing adipisicing proident excepteur veniam.",
          style: AppTypography.body2RegularStyle,
        ),
        Gap(AppSizesManager.s12),
        Row(
          children: [
            Icon(Icons.check_box, color: AppColors.accentGreenShade2),
            Gap(AppSizesManager.s8),
            Text(
              ' Caractéristiques principales',
              style: AppTypography.headLine3SemiBoldStyle,
            ),
          ],
        ),
        Gap(AppSizesManager.s12),
        Text(
          "Sint voluptate adipisicing deserunt culpa reprehenderit sint in do consectetur duis id eu. Occaecat officia do consectetur voluptate reprehenderit voluptate velit consectetur occaecat cupidatat nisi. Cupidatat ullamco aliqua magna qui eiusmod ad ex. Cillum non cupidatat irure excepteur veniam labore sit quis occaecat. Enim laborum proident id excepteur esse adipisicing laborum amet ex. Esse est adipisicing ad laboris duis ullamco tempor magna commodo excepteur et ea irure. Aliqua eu est qui amet velit culpa elit ea dolor adipisicing adipisicing proident excepteur veniam.",
          style: AppTypography.body2RegularStyle,
        ),
      ]),
    );
  }
}
