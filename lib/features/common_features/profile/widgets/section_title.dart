import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? iconPath;
  const SectionTitle({this.iconPath, required this.title, super.key});

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
          ],
        ));
  }
}
