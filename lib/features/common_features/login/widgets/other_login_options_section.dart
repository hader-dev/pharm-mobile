import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/assets_strings.dart';
import '../../../common/widgets/social_media_button.dart';

class OtherLoginOptionsSection extends StatelessWidget {
  const OtherLoginOptionsSection({super.key});

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
        const ResponsiveGap.s16(),
        Text('Or Sign in with',
            style: context.responsiveTextTheme.current.body3Medium.copyWith(
              color: TextColors.ternary.color,
            )),
        const ResponsiveGap.s16(),
        Row(
          children: [
            SocialMediaButton(
              iconPath: DrawableAssetStrings.appleIcon,
              onTap: () {},
            ),
            const ResponsiveGap.s8(),
            SocialMediaButton(
              iconPath: DrawableAssetStrings.googleIcon,
              onTap: () {},
            ),
            const ResponsiveGap.s8(),
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
