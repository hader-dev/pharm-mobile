import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart' show AppColors;
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart' show ResponsiveGap;
import 'package:hader_pharm_mobile/models/announcement.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart' show DateTimeHelper;

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
    return GestureDetector(
      onTap: () {
        RoutingManager.router.pushNamed(
          RoutingManager.announcementDetailsScreen,
          extra: announcement.id,
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
              imageUrl: getItInstance.get<INetworkService>().getFilesPath(announcement.thumbnailImage?.path ?? ""),
              width: double.infinity,
              height: double.infinity,
              errorStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(color: Colors.grey.shade400),
              errorMsg: "No Image Available",
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveAppSizeTheme.current.p8,
                  vertical: context.responsiveAppSizeTheme.current.p8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                  gradient: LinearGradient(
                    tileMode: TileMode.decal,
                    colors: [
                      Colors.transparent,
                      Colors.black26,
                      Colors.black38,
                      Colors.black45,
                      Colors.black54,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                        announcement.company?.thumbnailImage?.path ?? "",
                                      ),
                                )
                              : AssetImage(DrawableAssetStrings.companyPlaceHolderImg),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const ResponsiveGap.s8(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          announcement.title,
                          maxLines: 1,
                          softWrap: true,
                          style: context.responsiveTextTheme.current.body2Medium
                              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const ResponsiveGap.s2(),
                        Text(
                          announcement.createdAt.formatYMD,
                          style: context.responsiveTextTheme.current.bodySmall.copyWith(color: Colors.white60),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
