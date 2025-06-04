import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../common/widgets/social_media_button.dart';

class OtherRegisterOptionsSection extends StatelessWidget {
  const OtherRegisterOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: AppColors.bgDisabled,
          thickness: 1,
          height: 1,
          indent: MediaQuery.sizeOf(context).width * 0.2,
          endIndent: MediaQuery.sizeOf(context).width * 0.2,
        ),
        Gap(AppSizesManager.s16),
        Text('Or Sign in with',
            style: AppTypography.body3MediumStyle.copyWith(
              color: TextColors.ternary.color,
            )),
        Gap(AppSizesManager.s16),
        Row(
          children: [
            SocialMediaButton(
              iconPath: DrawableAssetStrings.appleIcon,
              onTap: () {},
            ),
            Gap(AppSizesManager.s8),
            SocialMediaButton(
              iconPath: DrawableAssetStrings.googleIcon,
              onTap: () {},
            ),
            Gap(AppSizesManager.s8),
            SocialMediaButton(
              iconPath: DrawableAssetStrings.facebookIcon,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
