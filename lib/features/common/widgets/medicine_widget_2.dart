import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/blackened_background.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

class MedicineWidget2 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  final bool hideLikeButton;
  final VoidCallback? onLikeTapped;
  final bool isLiked;
  final bool hideRemoveButton;
  final VoidCallback? onRemoveFromFavorites;
  const MedicineWidget2({
    super.key,
    required this.medicineData,
    this.onLikeTapped,
    required this.isLiked,
    this.hideLikeButton = true,
    this.hideRemoveButton = true,
    this.onRemoveFromFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.responsiveAppSizeTheme.current.p8,
          vertical: context.responsiveAppSizeTheme.current.p12),
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
              margin: EdgeInsets.only(
                  right: context.responsiveAppSizeTheme.current.p8),
              clipBehavior: Clip.antiAlias,
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    context.responsiveAppSizeTheme.current.r6),
                border: medicineData.image != null
                    ? null
                    : Border.all(
                        color: AppColors.bgDisabled,
                      ),
              ),
              child: Stack(
                children: [
                  medicineData.image != null
                      ? CacheNetworkImagePlus(
                          boxFit: BoxFit.cover,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          imageUrl: getItInstance
                              .get<INetworkService>()
                              .getFilesPath(medicineData.image?.path ?? ''),
                        )
                      : Image(
                          image: AssetImage(
                              DrawableAssetStrings.medicinePlaceHolderImg),
                          fit: BoxFit.cover,
                          height: double.maxFinite,
                          width: double.maxFinite,
                        ),
                  if (medicineData.image != null) BlackenedBackground(),
                  StockAvaillableContainerWidget(
                      isAvaillable: medicineData.stockQuantity > 0),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!hideLikeButton)
                    Row(children: [
                      Expanded(
                        flex: 8,
                        child: Text(medicineData.dci,
                            softWrap: true,
                            style: context
                                .responsiveTextTheme.current.headLine4SemiBold
                                .copyWith(color: TextColors.primary.color)),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () {
                            onLikeTapped?.call();
                          },
                          icon: Icon(
                            isLiked ? Iconsax.heart5 : Iconsax.heart,
                            color: isLiked ? Colors.red : Colors.black,
                            size: context
                                .responsiveAppSizeTheme.current.iconSize25,
                          ),
                        ),
                      )
                    ]),
                  if (!hideRemoveButton)
                    Row(children: [
                      if (medicineData.dci != null)
                        Text(medicineData.dci,
                            softWrap: true,
                            style: context
                                .responsiveTextTheme.current.headLine4SemiBold
                                .copyWith(color: TextColors.primary.color)),
                      const Spacer(),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          onRemoveFromFavorites?.call();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size:
                              context.responsiveAppSizeTheme.current.iconSize16,
                        ),
                      )
                    ]),
                  const Spacer(),
                  Row(children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.bgDisabled, width: 1.5),
                        image: DecorationImage(
                          image: medicineData.company?.thumbnailImage?.path ==
                                  null
                              ? AssetImage(
                                  DrawableAssetStrings.companyPlaceHolderImg)
                              : NetworkImage(
                                  getItInstance
                                      .get<INetworkService>()
                                      .getFilesPath(
                                        medicineData
                                            .company!.thumbnailImage!.path,
                                      ),
                                ),
                        ),
                      ),
                    ),
                    ResponsiveGap.s4(),
                    Text(
                        medicineData.company?.name ??
                            context.translation!.unknown,
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
                        size: context.responsiveAppSizeTheme.current.iconSize18,
                      ),
                      ResponsiveGap.s4(),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: medicineData.unitPriceHt.formatAsPrice(),
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
            )
          ],
        ),
      ),
    );
  }
}
