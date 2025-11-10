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

class PromotionItemWidget4 extends StatelessWidget {
  final AnnouncementModel announcement;
  final OnTapCallback? onTap;
  final Color? filterColor;
  final Color? onForegroundColor;
  final double? height;
  final double? width;

  const PromotionItemWidget4({
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
    return InkWell(
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
            flex: 3,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImageWithAssetFallback(
                width: double.infinity,
                imageUrl: getItInstance
                    .get<INetworkService>()
                    .getFilesPath(announcement.thumbnailImage?.path ?? ""),
                assetImage: DrawableAssetStrings.companyPlaceHolderImg,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const ResponsiveGap.s8(),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: context.responsiveAppSizeTheme.current.iconSize30,
                  width: context.responsiveAppSizeTheme.current.iconSize30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                    image: DecorationImage(
                      image: announcement.company?.thumbnailImage != null
                          ? NetworkImage(
                              getItInstance.get<INetworkService>().getFilesPath(
                                    announcement
                                            .company?.thumbnailImage?.path ??
                                        "",
                                  ),
                            )
                          : AssetImage(
                              DrawableAssetStrings.companyPlaceHolderImg),
                    ),
                  ),
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        announcement.title,
                        style: context
                            .responsiveTextTheme.current.headLine3Medium
                            .copyWith(
                          color: AppColors.accent1Shade1,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                      const ResponsiveGap.s4(),
                      Text(
                        announcement.createdAt.formatYMD,
                        style: context.responsiveTextTheme.current.body3Medium
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
