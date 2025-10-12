import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaWidget1 extends StatelessWidget {
  final BaseParaPharmaCatalogModel paraPharmData;
  final bool canOrder;
  final void Function(BaseParaPharmaCatalogModel)? onFavoriteCallback;
  final bool isLiked;
  const ParaPharmaWidget1(
      {super.key,
      required this.paraPharmData,
      required this.isLiked,
      this.canOrder = true,
      this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p8, vertical: AppSizesManager.p12),
      child: InkWell(
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;

          GoRouter.of(context).pushNamed(RoutingManager.paraPharmaDetailsScreen,
              extra: {"id": paraPharmData.id, "canOrder": canOrderBasedOnRole});
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: AppSizesManager.p8),
              clipBehavior: Clip.antiAlias,
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesManager.r6),
                border: paraPharmData.image != null
                    ? null
                    : Border.all(
                        color: AppColors.bgDisabled,
                      ),
              ),
              child: Stack(
                children: [
                  if (paraPharmData.image != null)
                    CacheNetworkImagePlus(
                      boxFit: BoxFit.cover,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      imageUrl: getItInstance
                          .get<INetworkService>()
                          .getFilesPath(paraPharmData.image?.path ?? ''),
                    )
                  else
                    Image(
                      image: AssetImage(
                          DrawableAssetStrings.paraPharmaPlaceHolderImg),
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                  if (paraPharmData.image != null)
                    Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black26,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black26,
                            ],
                          ),
                        ),
                        child: null),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    paraPharmData.name,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: context.responsiveTextTheme.current.headLine4SemiBold
                        .copyWith(color: TextColors.primary.color),
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.bgDisabled, width: 1.5),
                        image: DecorationImage(
                          image: paraPharmData.company?.thumbnailImage?.path ==
                                  null
                              ? AssetImage(
                                  DrawableAssetStrings.companyPlaceHolderImg)
                              : NetworkImage(
                                  getItInstance
                                      .get<INetworkService>()
                                      .getFilesPath(
                                        paraPharmData
                                            .company!.thumbnailImage!.path,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    const ResponsiveGap.s4(),
                    Text(paraPharmData.company?.name ?? "",
                        style: context.responsiveTextTheme.current.bodyXSmall
                            .copyWith(
                                fontWeight: context.responsiveTextTheme.current
                                    .appFont.appFontSemiBold,
                                color: TextColors.primary.color)),
                  ]),
                  Row(
                    children: [
                      Icon(
                        Iconsax.wallet_money,
                        color: AppColors.accent1Shade1,
                        size: AppSizesManager.iconSize18,
                      ),
                      ResponsiveGap.s4(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: double.parse(paraPharmData.unitPriceHt)
                                  .formatAsPrice(),
                              style: context
                                  .responsiveTextTheme.current.headLine3SemiBold
                                  .copyWith(color: AppColors.accent1Shade1),
                            ),
                            TextSpan(
                              text: " ${context.translation!.currency}",
                              style: context
                                  .responsiveTextTheme.current.bodyXSmall
                                  .copyWith(color: AppColors.accent1Shade1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (onFavoriteCallback != null)
              IconButton(
                icon: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.accent1Shade1.withAlpha(150),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isLiked ? Iconsax.heart5 : Iconsax.heart,
                    color: isLiked ? Colors.red : Colors.black,
                    size: AppSizesManager.iconSize30,
                  ),
                ),
                onPressed: () {
                  onFavoriteCallback?.call(paraPharmData);
                },
              ),
          ],
        ),
      ),
    );
  }
}
