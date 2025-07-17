import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/features/common/dialog/log_out_dialog.dart';
import 'package:iconsax/iconsax.dart';

import 'package:lucide_icons/lucide_icons.dart';

import '../../../config/routes/routing_manager.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/constants.dart';

import '../../common/app_bars/custom_app_bar.dart';
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
                        child: SectionTitle(title: "Account Settings"),
                      ),
                      SettingsTile(
                          icon: LucideIcons.lock,
                          title: "Change Password",
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutingManager.changePasswordScreen);
                          }),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p8),
                        child: SectionTitle(title: "preferences"),
                      ),
                      SettingsTile(
                          icon: LucideIcons.heart,
                          title: "Favorites",
                          onTap: () {
                            GoRouter.of(context).pushNamed(RoutingManager.favoritesScreen);
                          }),
                      SettingsTile(
                        icon: LucideIcons.globe,
                        title: "language",
                        onTap: () {
                          GoRouter.of(context).pushNamed(RoutingManager.languagesScreen);
                        },
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p8),
                        child: SectionTitle(title: "App Privarcy"),
                      ),
                      SettingsTile(
                        icon: LucideIcons.fileText,
                        title: "legal And Policies",
                      ),
                      SettingsTile(
                        icon: LucideIcons.helpCircle,
                        title: "help And Support",
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

                            GoRouter.of(context).pushReplacementNamed(RoutingManager.loginScreen);
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
