import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart' show DrawableAssetStrings;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class ImageLoadErrorWidget extends StatelessWidget {
  final double? iconSize;
  final String? iconPath;
  final String? errorMsg;
  final TextStyle? errorStyle;
  final Color? iconColor;

  const ImageLoadErrorWidget({super.key, this.iconPath, this.iconSize, this.errorMsg, this.errorStyle, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath ?? DrawableAssetStrings.noImgPlaceHolderIcon,
          height: iconSize ?? context.responsiveAppSizeTheme.current.iconSize25,
          width: iconSize ?? context.responsiveAppSizeTheme.current.iconSize25,
          colorFilter: ColorFilter.mode(iconColor ?? const Color.fromARGB(255, 221, 220, 220), BlendMode.srcIn),
        ),
        if (errorMsg != null) ...[
          ResponsiveGap.s12(),
          Text(errorMsg!,
              style: errorStyle ?? context.responsiveTextTheme.current.bodySmall.copyWith(color: Colors.grey.shade400))
        ]
      ],
    );
  }
}
