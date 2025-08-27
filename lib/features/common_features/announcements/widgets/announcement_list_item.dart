import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/image_load_error_widget.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

class AnnouncementListItem extends StatelessWidget {
  final AnnouncementModel announcement;

  const AnnouncementListItem({
    super.key,
    required this.announcement,
  });

  @override
  Widget build(BuildContext context) {
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
          borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizesManager.commonWidgetsRadius),
                topRight: Radius.circular(AppSizesManager.commonWidgetsRadius),
              ),
              child: SizedBox(
                height: 180,
                width: double.infinity,
                child: announcement.thumbnailImage != null && announcement.thumbnailImage!.path.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: getItInstance
                            .get<INetworkService>()
                            .getFilesPath(announcement.thumbnailImage!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.bgDarken,
                          child: const Center(
                            child: ImageLoadErrorWidget(),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          color: AppColors.bgDarken,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.bgDarken,
                        child: const Center(
                          child: ImageLoadErrorWidget(),
                        ),
                      ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSizesManager.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
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
                  // Description
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
                  // Date or additional info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'View Details',
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
