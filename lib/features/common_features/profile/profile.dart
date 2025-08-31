import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/app_bars/custom_app_bar_v2.dart';
import 'package:hader_pharm_mobile/features/common/dialog/log_out_dialog.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/edit_company.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/login_jwt_decoder.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'widgets/profile_header.dart';
import 'widgets/section_title.dart';
import 'widgets/settings_tile.dart';

class ProfileScreen extends StatefulWidget {
  final String openedFrom;
  const ProfileScreen({super.key, required this.openedFrom});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileUpdateKey = DateTime.now().millisecondsSinceEpoch.toString();

  bool get _userHasCompany {
    final token = getItInstance.get<TokenManager>().token;
    if (token != null) {
      JwtDecoded decodedJwt = decodeJwt(token);
      return decodedJwt.companyId != null && decodedJwt.companyId != "null";
    }
    return false;
  }

  bool get _isPharmacyManager {
    final currentUser = getItInstance.get<UserManager>().currentUser;
    return currentUser.role.isPharmacyManager;
  }

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
            style: context.responsiveTextTheme.current.headLine3SemiBold
                .copyWith(color: AppColors.bgWhite),
          ),
        ),
        body: Column(
          children: <Widget>[
            Gap(AppSizesManager.s16),
            Padding(
              padding: EdgeInsets.only(left: AppSizesManager.p4),
              child: ProfileHeader(key: ValueKey(_profileUpdateKey)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizesManager.p8,
                    vertical: AppSizesManager.p4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizesManager.p8,
                            vertical: AppSizesManager.p10),
                        child: SectionTitle(
                            title: context.translation!.account_settings),
                      ),
                      SettingsTile(
                          icon: LucideIcons.userCog,
                          title: context.translation!.edit_profile,
                          onTap: () async {
                            await GoRouter.of(context)
                                .pushNamed(RoutingManager.editProfileScreen);
                            setState(() {
                              _profileUpdateKey = DateTime.now().millisecondsSinceEpoch.toString();
                            });
                          }),
                      if (_userHasCompany)
                      
                        _isPharmacyManager
                            ? SettingsTile(
                                icon: LucideIcons.edit,
                                title: context.translation!.edit_company,
                                onTap: () async {
                                  try {
                                    await GoRouter.of(context)
                                        .pushNamed(RoutingManager.editCompanyScreen, 
                                            extra: CompanyScreenMode.edit);
                                    setState(() {});
                                  } catch (e) {
                                    debugPrint("Error navigating to edit company: $e");
                                  }
                                })
                            : SettingsTile(
                                icon: LucideIcons.building,
                                title: context.translation!.view_company,
                                onTap: () async {
                                  try {
                                    await GoRouter.of(context)
                                        .pushNamed(RoutingManager.editCompanyScreen, 
                                            extra: CompanyScreenMode.view);
                                    setState(() {});
                                  } catch (e) {
                                    // If there's an error, user might need to create company
                                    debugPrint("Error navigating to view company: $e");
                                  }
                                })
                      else if (_isPharmacyManager)
                        SettingsTile(
                            icon: LucideIcons.plus,
                            title: context.translation!.create_company_action,
                            onTap: () async {
                              await GoRouter.of(context)
                                  .pushNamed(RoutingManager.createCompanyProfile);
                              setState(() {});
                            }),
                      SettingsTile(
                          icon: LucideIcons.lock,
                          title: context.translation!.change_password,
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RoutingManager.changePasswordScreen);
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizesManager.p6,
                            vertical: AppSizesManager.p8),
                        child: SectionTitle(
                            title: context.translation!.preferences),
                      ),
                      SettingsTile(
                          icon: LucideIcons.heart,
                          title: context.translation!.favorites,
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RoutingManager.favoritesScreen);
                          }),
                      SettingsTile(
                        icon: LucideIcons.globe,
                        title: context.translation!.language,
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(RoutingManager.languagesScreen);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSizesManager.p6,
                            vertical: AppSizesManager.p8),
                        child: SectionTitle(
                          title: context.translation!.app_privacy,
                        ),
                      ),
                      SettingsTile(
                          icon: LucideIcons.fileText,
                          title: context.translation!.legal_policies,
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RoutingManager.legalPoliciesScreen);
                          }),
                      SettingsTile(
                        icon: LucideIcons.helpCircle,
                        title: context.translation!.help_support,
                        onTap: (){
                          GoRouter.of(context)
                              .pushNamed(RoutingManager.helpSupportScreen);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizesManager.p6,
                        ),
                        child: ListTile(
                          leading:
                              const Icon(LucideIcons.logOut, color: Colors.red),
                          title: Text(context.translation!.logout,
                              style: const TextStyle(color: Colors.red)),
                          onTap: () async {
                            await AppDialogs.showLogoutDialogLogout(context);

                            if (context.mounted) {
                              GoRouter.of(context).pushReplacementNamed(
                                  RoutingManager.loginScreen);
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
