import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/features/common/dialog/log_out_dialog.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lucide_icons/lucide_icons.dart';

import '../../../config/routes/routing_manager.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';

import '../../common/app_bars/custom_app_bar.dart';
import '../../common/dialog/validation_dialog.dart';
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
        appBar: CustomAppBar(
          bgColor: AppColors.bgWhite,
          topPadding: MediaQuery.of(context).padding.top,
          bottomPadding: MediaQuery.of(context).padding.bottom,
          leading: IconButton(
            icon: const Icon(
              Iconsax.profile_circle,
              size: AppSizesManager.iconSize25,
            ),
            onPressed: () {},
          ),
          title: const Text(
            "Account",
            style: AppTypography.headLine3SemiBoldStyle,
          ),
          // trailing: [
          //   // IconButton(
          //   //   icon: const Icon(Iconsax.search_normal),
          //   //   onPressed: () {},
          //   // ),
          //   // IconButton(
          //   //   icon: const Icon(Iconsax.notification),
          //   //   onPressed: () {},
          //   // ),
          // ],
        ),
        body: Column(
          children: <Widget>[
            // ProfileAppBar(
            //   isBackButtonEnabled: openedFrom == 'from shop' ? true : false,
            // ),
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
                        child: SectionTitle(title: "Account Settings"),
                      ),
                      // SettingsTile(
                      //   icon: LucideIcons.user,
                      //   title: 'Edit Profile',
                      //   onTap: () {
                      //     GoRouter.of(context).pushNamed(RoutingManager.editProfileScreen);
                      //   },
                      // ),
                      SettingsTile(
                          icon: LucideIcons.lock,
                          title: "Change Password",
                          onTap: () {
                            // GoRouter.of(context).pushNamed(RoutingManager.changePasswordScreen);
                          }),
                      // SettingsTile(
                      //     icon: LucideIcons.bell,
                      //     title: 'Notifications',
                      //     onTap: () {
                      //       GoRouter.of(context).pushNamed(RoutingManager.notificationSettingsScreen);
                      //     }),
                      SettingsTile(
                          icon: LucideIcons.globe,
                          title: "language",
                          // trailing: Text(LanguageHelper.getLanguageName(context.read<LangCubit>().appLang),
                          //     style: const TextStyle(color: Colors.grey)),
                          onTap: () {
                            // GoRouter.of(context).pushNamed(RoutingManager.languageScreen);
                          }),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p8),
                        child: SectionTitle(title: "preferences"),
                      ),
                      SettingsTile(
                        icon: LucideIcons.fileText,
                        title: "legal And Policies",
                        // onTap: () {
                        //   GoRouter.of(context).pushNamed(RoutingManager.legalPoliciesScreen);
                        // }
                      ),
                      SettingsTile(
                        icon: LucideIcons.helpCircle,
                        title: "help And Support",
                        // onTap: () {
                        //   GoRouter.of(context).pushNamed(RoutingManager.helpCenterScreen);
                        // }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizesManager.p6,
                        ),
                        child: ListTile(
                          leading: const Icon(LucideIcons.logOut, color: Colors.red),
                          title: Text("logout", style: const TextStyle(color: Colors.red)),
                          onTap: () async {
                            await AppDialogs.showLogoutDialogLogout();

                            GoRouter.of(context).goNamed(RoutingManager.loginScreen);
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
