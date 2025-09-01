import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class AnnouncementListItem extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementListItem({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return GestureDetector(
      onTap: () {
        RoutingManager.router.pushNamed(
          RoutingManager.announcementDetailsScreen,
          extra: announcement.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(150),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizesManager.commonWidgetsRadius),
                topRight: Radius.circular(AppSizesManager.commonWidgetsRadius),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: CachedNetworkImageWithAssetFallback(
                  imageUrl: getItInstance
                      .get<INetworkService>()
                      .getFilesPath(announcement.thumbnailImage?.path ?? ""),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizesManager.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (announcement.content.isNotEmpty)
                    Text(
                      announcement.content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translation.show_more,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.accent1Shade1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: AppColors.accent1Shade1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
