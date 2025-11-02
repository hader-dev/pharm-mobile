import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/actions/show_new_app_version_dialog.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/mobile_app_version.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class UpdateAvailableWidget extends StatelessWidget {
  const UpdateAvailableWidget({super.key, required this.mobileAppVersion});
  final MobileAppVersion mobileAppVersion;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
          context.responsiveAppSizeTheme.current.commonWidgetsRadius),
      child: Padding(
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.system_update_alt,
                size: context.responsiveAppSizeTheme.current.iconSize48,
                color: AppColors.accent1Shade1),
            const ResponsiveGap.s12(),
            Text(
              mobileAppVersion.isUpdateAvaillable
                  ? translation.new_version_available
                  : translation.app_version_is_already_latest,
              style: context.responsiveTextTheme.current.headLine4SemiBold,
            ),
            const ResponsiveGap.s8(),
            Text(
              '${translation.version}: ${mobileAppVersion.version}',
              style: context.responsiveTextTheme.current.body2Regular,
            ),
            if (mobileAppVersion.isUpdateAvaillable) const ResponsiveGap.s16(),
            if (mobileAppVersion.isUpdateAvaillable)
              PrimaryTextButton(
                label: translation.update_now,
                labelColor: Colors.white,
                color: AppColors.accent1Shade1,
                onTap: () => openAppUpdateLink(mobileAppVersion.url),
              ),
          ],
        ),
      ),
    );
  }
}
