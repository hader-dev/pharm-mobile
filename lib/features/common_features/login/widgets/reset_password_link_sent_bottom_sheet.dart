import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';

class CheckYourMailScreen extends StatelessWidget {
  const CheckYourMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Email Icon/Image
          SvgPicture.asset(
            DrawableAssetStrings.emailIcon, // Replace with your actual asset
            height: 150,
            width: 150,
          ),

          // Title
          Text(context.translation!.checkEmail, style: AppTypography.headLine1Style),

          const Gap(AppSizesManager.s24),

          // Subtitle
          Text(context.translation!.passwordResetSent,
              textAlign: TextAlign.center, style: AppTypography.body1RegularStyle),

          const Gap(AppSizesManager.s24),
          PrimaryTextButton(
              label: context.translation!.backToLogin,
              onTap: () {
                context.pop();
              },
              color: AppColors.accent1Shade1),
        ],
      ),
    );
  }
}
