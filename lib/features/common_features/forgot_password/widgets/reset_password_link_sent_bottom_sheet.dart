import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class PasswordResetLinkSentScreen extends StatelessWidget {
  const PasswordResetLinkSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            DrawableAssetStrings.emailIcon,
            height: 150,
            width: 150,
          ),
          Text(context.translation!.check_email,
              style: context.responsiveTextTheme.current.headLine1),
          const ResponsiveGap.s24(),
          Text(context.translation!.password_reset_sent,
              textAlign: TextAlign.center,
              style: context.responsiveTextTheme.current.body1Regular),
          const ResponsiveGap.s24(),
          PrimaryTextButton(
              label: context.translation!.back_to_login,
              onTap: () {
                context.pop();
              },
              color: AppColors.accent1Shade1),
        ],
      ),
    );
  }
}
