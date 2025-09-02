import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnTapCallback = void Function(AnnouncementModel announcement);

class PromotionItemWidget extends StatelessWidget {
  final AnnouncementModel announcement;
  final OnTapCallback? onTap;
  final Color? filterColor;
  final Color? onForegroundColor;

  const PromotionItemWidget({
    super.key,
    required this.announcement,
    this.onTap,
    this.filterColor,
    this.onForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          RoutingManager.router.pushNamed(
            RoutingManager.announcementDetailsScreen,
            extra: announcement.id,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImageWithAssetFallback(
                width: double.infinity,
                imageUrl: getItInstance
                    .get<INetworkService>()
                    .getFilesPath(announcement.thumbnailImage?.path ?? ""),
                fit: BoxFit.cover,
                assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
              ),
            ),
            const Divider(
              color: AppColors.accent1Shade1,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(AppSizesManager.p8),
                child: Column(
                  children: [
                    Text(
                      announcement.title,
                      style: context
                          .responsiveTextTheme.current.headLine3SemiBold
                          .copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    const ResponsiveGap.s2(),
                    Text(
                      announcement.title,
                      style: context.responsiveTextTheme.current.body3Regular
                          .copyWith(
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
