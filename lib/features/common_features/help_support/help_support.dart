import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common_features/help_support/actions/launch_developer_email.dart';
import 'package:hader_pharm_mobile/features/common_features/help_support/actions/launch_developer_phone.dart';
import 'package:hader_pharm_mobile/features/common_features/profile/widgets/settings_tile.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarV2.alternate(
          leading: IconButton(
            icon: const Icon(
              Iconsax.arrow_left,
              color: Colors.white,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            translation.help_and_support,
            style:
                context.responsiveTextTheme.current.headLine3SemiBold.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Gap(AppSizesManager.s24),
            SettingsTile(
              icon: LucideIcons.mail,
              title: context.translation!.email,
              onTap: launchDeveloperEmail,
              subtitle: email,
            ),
            SettingsTile(
              icon: LucideIcons.phone,
              title: context.translation!.help_support,
              onTap: launchDeveloperPhoneCall,
              subtitle: phone,
            ),
          ],
        ),
      ),
    );
  }
}
