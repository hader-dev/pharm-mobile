import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';

class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  const SocialMediaButton(
      {super.key, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.bgDisabled, width: 1),
            borderRadius: BorderRadius.circular(
                context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          ),
          child: SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
