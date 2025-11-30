import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/blackened_background.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class MedicineWidget2 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  final bool hideLikeButton;
  final VoidCallback? onLikeTapped;
  final bool isLiked;
  final bool hideRemoveButton;
  final VoidCallback? onRemoveFromFavorites;
  final void Function(BaseMedicineCatalogModel)? onQuickAddCallback;

  const MedicineWidget2({
    super.key,
    required this.medicineData,
    this.onLikeTapped,
    required this.isLiked,
    this.hideLikeButton = true,
    this.hideRemoveButton = true,
    this.onRemoveFromFavorites,
    this.onQuickAddCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8, vertical: context.responsiveAppSizeTheme.current.p12),
      child: InkWell(
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;
          GoRouter.of(context).pushNamed(RoutingManager.medicineDetailsScreen,
              extra: {"id": medicineData.id, "canOrder": canOrderBasedOnRole});
        },
        splashColor: Colors.transparent,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: context.responsiveAppSizeTheme.current.p8),
              clipBehavior: Clip.antiAlias,
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
                border: medicineData.image != null
                    ? null
                    : Border.all(
                        color: AppColors.bgDisabled,
                      ),
              ),
              child: Stack(
                children: [
                  CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(medicineData.image?.path ?? ""),
                    width: double.infinity,
                    height: double.infinity,
                    errorStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(color: Colors.grey.shade400),
                    errorMsg: "No Image Available",
                    fit: BoxFit.cover,
                  ),
                  if (medicineData.image != null) BlackenedBackground(),
                  StockAvailableContainerWidget(isAvailable: medicineData.stockQuantity > 0),
                  if (!hideLikeButton)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            isLiked ? Iconsax.heart5 : Iconsax.heart,
                            color: isLiked ? Colors.red : Colors.grey[400],
                            size: context.responsiveAppSizeTheme.current.iconSize20,
                          ),
                        ),
                        onTap: () {
                          onLikeTapped?.call();
                        },
                      ),
                    )
                ],
              ),
            ),
            const ResponsiveGap.s4(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      flex: 8,
                      child: Text(medicineData.dci,
                          softWrap: true,
                          style: context.responsiveTextTheme.current.headLine4SemiBold
                              .copyWith(color: TextColors.primary.color)),
                    ),
                    const Spacer(),
                    if (onQuickAddCallback != null)
                      Transform.scale(
                        scale: .88,
                        child: PrimaryIconButton(
                          isBordered: false,
                          bgColor: AppColors.accent1Shade1.withAlpha(20),
                          onPressed: () {
                            onQuickAddCallback?.call(medicineData);
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
                  ]),
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bgDisabled, width: 1.2),
                          image: DecorationImage(
                            image: medicineData.company?.thumbnailImage?.path == null
                                ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                                : NetworkImage(
                                    getItInstance.get<INetworkService>().getFilesPath(
                                          medicineData.company!.thumbnailImage!.path,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                      const ResponsiveGap.s4(),
                      Text(medicineData.company!.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: context.responsiveTextTheme.current.bodyXSmall),
                    ],
                  ),
                  ResponsiveGap.s6(),
                  PriceWidget(
                    price: medicineData.unitPriceHt,
                    overridePrice: medicineData.unitPriceHt,
                    mainStyle:
                        context.responsiveTextTheme.current.headLine4SemiBold.copyWith(color: AppColors.accent1Shade1),
                    currencyStyle: context.responsiveTextTheme.current.bodyXSmall
                        .copyWith(color: AppColors.accent1Shade1, fontSize: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
