import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

typedef OnTapCallback = void Function(AnnouncementModel announcement);

class PromotionItemWidget2 extends StatelessWidget {
  final AnnouncementModel announcement;
  final OnTapCallback? onTap;
  final Color? filterColor;
  final Color? onForegroundColor;

  const PromotionItemWidget2({
    super.key,
    required this.announcement,
    this.onTap,
    this.filterColor,
    this.onForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizesManager.s16),
      child: InkWell(
        onTap: () {
          RoutingManager.router.pushNamed(
            RoutingManager.announcementDetailsScreen,
            extra: announcement.id,
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.accent1Shade1,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppSizesManager.s16),
          ),
          child: CachedNetworkImageWithAssetFallback(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            imageUrl: getItInstance
                .get<INetworkService>()
                .getFilesPath(announcement.thumbnailImage?.path ?? ""),
            assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
          ),
        ),
      ),
    );
  }
}
