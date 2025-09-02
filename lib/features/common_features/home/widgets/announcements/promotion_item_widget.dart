import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/image_load_error_widget.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
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
            left: AppSizesManager.s8,
            top: AppSizesManager.s8,
            child: Padding(
              padding: const EdgeInsets.only(right: AppSizesManager.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    announcement.title,
                    style:
                        context.responsiveTextTheme.current.headLine2.copyWith(
                      color: onForegroundColor,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                  const ResponsiveGap.s4(),
                  Text(
                    announcement.title,
                    style: context.responsiveTextTheme.current.body1Regular
                        .copyWith(
                      color: onForegroundColor,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: AppSizesManager.s16,
            left: AppSizesManager.s8,
            child: ElevatedButton(
              onPressed: () => onTap?.call(announcement),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
              ),
              child: Text(translation.learn_more),
            ),
          )
        ],
      ),
    );
  }
}
