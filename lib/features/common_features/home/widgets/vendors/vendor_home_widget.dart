import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart'
    show CacheNetworkImagePlus;
import 'package:flutter/material.dart' show Colors, InkWell, Icons;
import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart'
    show ResponsiveGap;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors;

class VendorHomeWidget extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final VoidCallback? onPress;

  final String fallbackAssetImagePlaceholderPath;

  const VendorHomeWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    this.onPress,
    required this.fallbackAssetImagePlaceholderPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        margin:
            EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p12),
        width: 250,
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          border: Border.all(
            color: const Color.fromARGB(186, 245, 245, 245),
          ),
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              height: 50,
              width: 50,
              padding:
                  EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.bgDarken2,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent1Shade1.withAlpha(50),
                ),
              ),
              child: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? CacheNetworkImagePlus(
                      boxFit: BoxFit.fill, imageUrl: imageUrl!)
                  : Image(
                      image: AssetImage(fallbackAssetImagePlaceholderPath),
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding:
                  EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style:
                          context.responsiveTextTheme.current.headLine3SemiBold,
                    ),
                    const ResponsiveGap.s8(),
                    InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'View',
                            style: context
                                .responsiveTextTheme.current.body3Medium
                                .copyWith(
                              color: AppColors.accent1Shade1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_sharp,
                            color: AppColors.accent1Shade1,
                            size: context
                                .responsiveAppSizeTheme.current.iconSize20,
                          ),
                        ],
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
