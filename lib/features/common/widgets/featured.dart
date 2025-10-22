import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FeaturedEntity extends StatelessWidget {
  const FeaturedEntity(
      {super.key,
      required this.title,
      required this.imageUrl,
      this.onPress,
      required this.fallbackAssetImagePlaceholderPath,
      required this.size});

  final String title;
  final String? imageUrl;
  final VoidCallback? onPress;
  final double size;
  final String fallbackAssetImagePlaceholderPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              ),
              padding: const EdgeInsets.all(AppSizesManager.p8),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? CacheNetworkImagePlus(
                        width: size,
                        height: (size * 0.6) - AppSizesManager.p8,
                        boxFit: BoxFit.cover,
                        imageUrl: imageUrl!)
                    : Center(
                        child: Image(
                          image: AssetImage(fallbackAssetImagePlaceholderPath),
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
              ),
            ),
            const ResponsiveGap.s4(),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.responsiveTextTheme.current.body3Medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
