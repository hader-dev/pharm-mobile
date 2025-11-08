import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/token_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_new_app_version_dialog.dart';
import 'package:hader_pharm_mobile/features/common/dialog/log_out_dialog.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/edit_company/edit_company_screen.dart';
import 'package:hader_pharm_mobile/models/jwt_decoded.dart';
import 'package:hader_pharm_mobile/utils/env_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/login_jwt_decoder.dart';
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
        body: Column(
          children: <Widget>[
            const ResponsiveGap.s16(),
            Padding(
              padding: EdgeInsets.only(
                  left: context.responsiveAppSizeTheme.current.p4),
              child: ProfileHeader(key: ValueKey(_profileUpdateKey)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveAppSizeTheme.current.p8,
                    vertical: context.responsiveAppSizeTheme.current.p4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                context.responsiveAppSizeTheme.current.p8,
                            vertical:
                                context.responsiveAppSizeTheme.current.p10),
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
                              _profileUpdateKey = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                            });
                          }),
                      if (_userHasCompany)
                        SettingsTile(
                            icon: _isPharmacyManager
                                ? LucideIcons.edit
                                : LucideIcons.building,
                            title: _isPharmacyManager
                                ? context.translation!.edit_company
                                : context.translation!.view_company,
                            onTap: () async {
                              await GoRouter.of(context).pushNamed(
                                  RoutingManager.editCompanyScreen,
                                  extra: _isPharmacyManager
                                      ? CompanyScreenMode.edit
                                      : CompanyScreenMode.view);
                            }),
                      SettingsTile(
                          icon: LucideIcons.lock,
                          title: context.translation!.change_password,
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(RoutingManager.changePasswordScreen);
                          }),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                context.responsiveAppSizeTheme.current.p6,
                            vertical:
                                context.responsiveAppSizeTheme.current.p8),
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
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                context.responsiveAppSizeTheme.current.p6,
                            vertical:
                                context.responsiveAppSizeTheme.current.p8),
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
                        onTap: () {
                          GoRouter.of(context)
                              .pushNamed(RoutingManager.helpSupportScreen);
                        },
                      ),
                      SettingsTile(
                        icon: LucideIcons.upload,
                        title: context.translation!.app_version,
                        subtitle:
                            EnvHelper.getStoredEnvValue(EnvHelper.appVersion),
                        onTap: () {
                          if (EnvHelper.getFeatureFlag(
                                  EnvHelper.featureFlagUpdatePopup) ==
                              true) {
                            showNewAppVersionDialog(triggerdManually: true);
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveAppSizeTheme.current.p6,
                        ),
                        child: ListTile(
                          leading: Icon(LucideIcons.logOut,
                              color: Colors.red,
                              size: context.deviceSize.width <=
                                      DeviceSizes.largeMobile.width
                                  ? context
                                      .responsiveAppSizeTheme.current.iconSize20
                                  : context.responsiveAppSizeTheme.current
                                      .iconSize16),
                          title: Text(context.translation!.logout,
                              style: context
                                  .responsiveTextTheme.current.body3Medium
                                  .copyWith(color: Colors.red)),
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
