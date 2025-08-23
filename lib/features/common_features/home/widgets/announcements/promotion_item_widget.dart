import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/widgets/image_load_error_widget.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
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
    final translation = context.translation!;

    return InkWell(
      onTap: () => onTap?.call(announcement),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: getItInstance
                .get<INetworkService>()
                .getFilesPath(announcement.thumbnailImage?.path ?? ''),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (context, url, error) => const ImageLoadErrorWidget(),
          ),
          if (filterColor != null)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: filterColor!.withAlpha(150),
            ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          announcement.title,
                          style: TextStyle(
                            color: onForegroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black)
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          announcement.title,
                          style: TextStyle(
                            color: onForegroundColor,
                            fontSize: 18,
                            height: 1.4,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => onTap?.call(announcement),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                  child: Text(translation.learn_more),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
