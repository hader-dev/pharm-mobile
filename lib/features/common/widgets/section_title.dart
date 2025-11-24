import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? iconPath;
  final bool isSeeAllEnabled;
  final VoidCallback? onSeeAllTap;
  const SectionTitle({this.iconPath, required this.title, super.key, this.isSeeAllEnabled = false, this.onSeeAllTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p10),
        child: Row(
          children: [
            if (iconPath != null) ...[
              SvgPicture.asset(
                iconPath!,
                height: context.responsiveAppSizeTheme.current.iconSize25,
                width: context.responsiveAppSizeTheme.current.iconSize25,
              ),
              ResponsiveGap.s8()
            ],
            Text(
              title,
              textAlign: TextAlign.start,
              style: context.responsiveTextTheme.current.headLine4SemiBold.copyWith(
                color: Colors.black,
              ),
            ),
            if (isSeeAllEnabled) ...[
              Spacer(),
              InkWell(
                onTap: onSeeAllTap,
                child: Text(
                  context.translation!.see_all,
                  style: context.responsiveTextTheme.current.bodySmall.copyWith(
                    color: AppColors.accent1Shade1,
                    fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                  ),
                ),
              ),
            ]
          ],
        ));
  }
}
