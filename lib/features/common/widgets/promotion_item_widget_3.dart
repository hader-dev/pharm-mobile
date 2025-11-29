import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';

typedef OnTapCallback = void Function(AnnouncementModel announcement);

class PromotionItemWidget3 extends StatelessWidget {
  final AnnouncementModel announcement;
  final OnTapCallback? onTap;
  final Color? filterColor;
  final Color? onForegroundColor;
  final double? height;
  final double? width;

  const PromotionItemWidget3({
    super.key,
    required this.announcement,
    this.onTap,
    this.height,
    this.width,
    this.filterColor,
    this.onForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          RoutingManager.router.pushNamed(
            RoutingManager.announcementDetailsScreen,
            extra: announcement.id,
          );
        },
        child: Padding(
          padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r8),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: CachedNetworkImageWithDrawableFallback.withErrorAssetImage(
                      imageUrl:
                          getItInstance.get<INetworkService>().getFilesPath(announcement.thumbnailImage?.path ?? ""),
                      errorAssetImagePath: DrawableAssetStrings.companyPlaceHolderImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const ResponsiveGap.s4(),
              Text(
                announcement.title,
                style: context.responsiveTextTheme.current.headLine3Medium.copyWith(
                  color: AppColors.accent1Shade1,
                ),
              ),
              const ResponsiveGap.s4(),
              Text(
                announcement.createdAt.formatYMD,
                style: context.responsiveTextTheme.current.body3Medium.copyWith(color: Colors.grey),
              ),
              const ResponsiveGap.s4(),
            ],
          ),
        ),
      ),
    );
  }
}
