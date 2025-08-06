import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/dialog/log_out_dialog.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lucide_icons/lucide_icons.dart';

import 'widgets/profile_header.dart';
import 'widgets/section_title.dart';
import 'widgets/settings_tile.dart';

class ProfileScreen extends StatelessWidget {
  final String openedFrom;
  const ProfileScreen({super.key, required this.openedFrom});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarV2.alternate(
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.profile_circle,
              size: AppSizesManager.iconSize25,
              color: AppColors.bgWhite,
            ),
            onPressed: () {},
          ),
          title: Text(
            context.translation!.account,
            style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.bgWhite),
          ),
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: AppSizesManager.p4),
              child: ProfileHeader(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p8, vertical: AppSizesManager.p4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p8, vertical: AppSizesManager.p10),
                        child: SectionTitle(title: context.translation!.account_settings),
                      ),
                      SettingsTile(
                          icon: LucideIcons.userCog,
                          title: context.translation!.edit_profile,
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutingManager.editProfileScreen);
                          }),
                      SettingsTile(
                          icon: LucideIcons.lock,
                          title: context.translation!.change_password,
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutingManager.changePasswordScreen);
                          }),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p8),
                        child: SectionTitle(title: context.translation!.preferences),
                      ),
                      SettingsTile(
                          icon: LucideIcons.heart,
                          title: context.translation!.favorites,
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutingManager.favoritesScreen);
                          }),
                      SettingsTile(
                        icon: LucideIcons.globe,
                        title: context.translation!.language,
                        onTap: () {
                          GoRouter.of(context).pushNamed(RoutingManager.languagesScreen);
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p8),
                        child: SectionTitle(title: context.translation!.app_privacy),
                      ),
                      SettingsTile(
                        icon: LucideIcons.fileText,
                        title: context.translation!.legal_policies,
                      ),
                      SettingsTile(
                        icon: LucideIcons.helpCircle,
                        title: context.translation!.help_support,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizesManager.p6,
                        ),
                        child: ListTile(
                          leading: const Icon(LucideIcons.logOut, color: Colors.red),
                          title: Text(context.translation!.logout, style: const TextStyle(color: Colors.red)),
                          onTap: () async {
                            await AppDialogs.showLogoutDialogLogout();

                            if(context.mounted){
                              GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
                            }

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
