import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/responsive/device_size.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Function()? onTap;
  const SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.subtitle,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.accentGreenShade1.withAlpha(40), width: 1),
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ),
        child: ListTile(
          contentPadding:
              context.deviceSize.width <= DeviceSizes.largeMobile.width
                  ? null
                  : EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          leading: Icon(
            icon,
            size: context.responsiveAppSizeTheme.current.iconSize20,
            color: const Color.fromARGB(179, 20, 112, 130),
          ),
          title: Text(
            title,
            style: context.responsiveTextTheme.current.body3Medium,
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: context.responsiveTextTheme.current.body3Medium
                      .copyWith(color: TextColors.ternary.color),
                )
              : null,
          trailing: trailing ??
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Iconsax.arrow_left_2
                    : Iconsax.arrow_right_3,
                size: context.responsiveAppSizeTheme.current.iconSize20,
              ),
          onTap: () {
            onTap?.call();
          },
        ),
      ),
    );
  }
}
