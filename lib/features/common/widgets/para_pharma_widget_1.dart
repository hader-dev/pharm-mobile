import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/blackened_background.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaWidget1 extends StatelessWidget {
  final BaseParaPharmaCatalogModel paraPharmData;
  final bool canOrder;
  final void Function(BaseParaPharmaCatalogModel)? onFavoriteCallback;
  final void Function(BaseParaPharmaCatalogModel)? onQuickAddCallback;

  final bool isLiked;
  final String route;
  const ParaPharmaWidget1(
      {super.key,
      required this.paraPharmData,
      required this.isLiked,
      this.canOrder = true,
      this.onQuickAddCallback,
      this.route = RoutingManager.paraPharmaDetailsScreen,
      this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8, vertical: context.responsiveAppSizeTheme.current.p12),
      child: InkWell(
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;

          GoRouter.of(context)
              .pushNamed(route, extra: {"id": paraPharmData.id, "canOrder": canOrder || canOrderBasedOnRole});
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
              clipBehavior: Clip.antiAlias,
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
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
                      imageUrl: getItInstance.get<INetworkService>().getFilesPath(paraPharmData.image?.path ?? ''),
                    )
                  else
                    Image(
                      image: AssetImage(DrawableAssetStrings.paraPharmaPlaceHolderImg),
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ),
                  if (paraPharmData.image != null) BlackenedBackground(),
                  StockAvailableContainerWidget(isAvailable: paraPharmData.stockQuantity > 0),
                  if (onFavoriteCallback != null)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        onPressed: () {
                          onFavoriteCallback?.call(paraPharmData);
                        },
                        icon: Icon(
                          isLiked ? Iconsax.heart5 : Iconsax.heart,
                          color: isLiked ? Colors.red : Colors.black,
                          size: context.responsiveAppSizeTheme.current.iconSize25,
                        ),
                      ),
                    )
                ],
              ),
            ),
            const ResponsiveGap.s4(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomChip(
                        label: paraPharmData.category?.name ?? paraPharmData.name,
                        color: AppColors.bgDarken,
                      ),
                      if (onQuickAddCallback != null)
                        PrimaryIconButton(
                          isBordered: false,
                          bgColor: AppColors.accent1Shade3.withAlpha(30),
                          onPressed: () {
                            onQuickAddCallback?.call(paraPharmData);
                          },
                          icon: SvgPicture.asset(DrawableAssetStrings.newAddToCartIcon,
                              height: context.responsiveAppSizeTheme.current.iconSize25,
                              width: context.responsiveAppSizeTheme.current.iconSize25,
                              colorFilter: ColorFilter.mode(
                                AppColors.accent1Shade1,
                                BlendMode.srcIn,
                              )),
                        ),
                    ],
                  ),
                  Text(
                    paraPharmData.name,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style:
                        context.responsiveTextTheme.current.headLine4SemiBold.copyWith(color: TextColors.primary.color),
                  ),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                        image: DecorationImage(
                          image: paraPharmData.company?.thumbnailImage?.path == null
                              ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                              : NetworkImage(
                                  getItInstance.get<INetworkService>().getFilesPath(
                                        paraPharmData.company!.thumbnailImage!.path,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    const ResponsiveGap.s4(),
                    Text(paraPharmData.company?.name ?? "",
                        style: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                            fontWeight: context.responsiveTextTheme.current.appFont.appFontSemiBold,
                            color: TextColors.ternary.color)),
                  ]),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p6),
                          child: SvgPicture.asset(DrawableAssetStrings.newMoneyIcon,
                              height: context.responsiveAppSizeTheme.current.iconSize16,
                              width: context.responsiveAppSizeTheme.current.iconSize16,
                              colorFilter: ColorFilter.mode(
                                AppColors.accent1Shade1,
                                BlendMode.srcIn,
                              ))),
                      const ResponsiveGap.s4(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: paraPharmData.unitPriceHt.formatAsPrice(),
                              style: context.responsiveTextTheme.current.headLine3SemiBold
                                  .copyWith(color: AppColors.accent1Shade1),
                            ),
                            TextSpan(
                              text: " ${context.translation!.currency}",
                              style: context.responsiveTextTheme.current.bodyXSmall
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
          ],
        ),
      ),
    );
  }
}
