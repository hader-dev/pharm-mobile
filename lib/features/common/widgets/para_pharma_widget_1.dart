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
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p4,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8, vertical: context.responsiveAppSizeTheme.current.p12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
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
                  StockAvailableContainerWidget(isAvailable: paraPharmData.stockQuantity > 0),
                  if (onFavoriteCallback != null)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            paraPharmData.isLiked ? Iconsax.heart5 : Iconsax.heart,
                            color: paraPharmData.isLiked ? Colors.red : Colors.grey[400],
                            size: context.responsiveAppSizeTheme.current.iconSize20,
                          ),
                        ),
                        onTap: () {
                          onFavoriteCallback?.call(paraPharmData);
                        },
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
                        Transform.scale(
                          scale: .88,
                          child: PrimaryIconButton(
                            isBordered: false,
                            bgColor: AppColors.accent1Shade1.withAlpha(20),
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
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bgDisabled, width: 1.2),
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
                      Text(paraPharmData.company!.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: context.responsiveTextTheme.current.bodyXSmall),
                    ],
                  ),
                  ResponsiveGap.s6(),
                  Tooltip(
                    message: paraPharmData.name,
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Text(paraPharmData.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: context.responsiveTextTheme.current.headLine3SemiBold
                            .copyWith(color: TextColors.primary.color)),
                  ),
                  ResponsiveGap.s6(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: paraPharmData.unitPriceHt.formatAsPriceForPrint(decimalDigits: 1),
                          style: context.responsiveTextTheme.current.headLine4SemiBold
                              .copyWith(color: AppColors.accent1Shade1),
                        ),
                        TextSpan(
                          text: " ${context.translation!.currency}",
                          style: context.responsiveTextTheme.current.bodyXSmall
                              .copyWith(color: AppColors.accent1Shade1, fontSize: 10),
                        ),
                      ],
                    ),
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
