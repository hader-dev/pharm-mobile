import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/help_support/actions/launch_developer_email.dart';
import 'package:hader_pharm_mobile/features/common_features/help_support/actions/launch_developer_phone.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/widgets/settings_tile.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  final String email = 'contact@hader-pharm.com';
  final String phone = '0660741514';

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Scaffold(
      appBar: CustomAppBarV2.normal(
        leading: IconButton(
          icon: Icon(
            Directionality.of(context) == TextDirection.rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
            color: AppColors.accent1Shade1,
            size: context.responsiveAppSizeTheme.current.iconSize25,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          translation.help_and_support,
          style: context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
            color: AppColors.accent1Shade1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ResponsiveGap.s24(),
            SettingsTile(
              icon: LucideIcons.mail,
              title: context.translation!.email,
              onTap: launchDeveloperEmail,
              subtitle: email,
            ),
            SettingsTile(
              icon: LucideIcons.phone,
              title: context.translation!.phone,
              onTap: launchDeveloperPhoneCall,
              subtitle: phone,
            ),
          ],
        ),
      ),
    );
  }
}
