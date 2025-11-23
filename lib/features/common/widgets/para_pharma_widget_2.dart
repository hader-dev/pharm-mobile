import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/price_widget.dart';
import 'package:hader_pharm_mobile/features/common/widgets/silver_tags.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ParaPharmaWidget2 extends StatelessWidget {
  final BaseParaPharmaCatalogModel paraPharmData;
  final void Function(BaseParaPharmaCatalogModel)? onFavoriteCallback;
  final bool displayTags;
  final bool showQuickAddButton;
  final bool canOrder;

  const ParaPharmaWidget2(
      {super.key,
      this.displayTags = false,
      this.canOrder = true,
      required this.paraPharmData,
      this.onFavoriteCallback,
      this.showQuickAddButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.responsiveAppSizeTheme.current.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(186, 245, 245, 245),
        ),
        borderRadius:
            BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
      ),
      child: InkWell(
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;

          GoRouter.of(context).pushNamed(RoutingManager.paraPharmaDetailsScreen,
              extra: {"id": paraPharmData.id, "canOrder": canOrderBasedOnRole});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: context.responsiveAppSizeTheme.current.p6,
                    vertical: context.responsiveAppSizeTheme.current.p6),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      context.responsiveAppSizeTheme.current.r6),
                  border: paraPharmData.image != null
                      ? null
                      : Border.all(
                          color: const Color.fromARGB(197, 245, 245, 245),
                        ),
                ),
                child: Stack(
                  children: [
                    paraPharmData.image != null
                        ? CacheNetworkImagePlus(
                            boxFit: BoxFit.contain,
                            width: double.maxFinite,
                            height: double.maxFinite,
                            imageUrl: getItInstance
                                .get<INetworkService>()
                                .getFilesPath(paraPharmData.image?.path ?? ''),
                          )
                        : Center(
                            child: Image(
                              image: AssetImage(DrawableAssetStrings
                                  .paraPharmaPlaceHolderImg),
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ),
                          ),
                    Row(
                      children: [
                        StockAvailableContainerWidget(
                            isAvailable: paraPharmData.stockQuantity > 0),
                        const Spacer(),
                        if (onFavoriteCallback != null)
                          InkWell(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                paraPharmData.isLiked
                                    ? Iconsax.heart5
                                    : Iconsax.heart,
                                color: paraPharmData.isLiked
                                    ? Colors.red
                                    : Colors.grey[400],
                                size: context
                                    .responsiveAppSizeTheme.current.iconSize20,
                              ),
                            ),
                            onTap: () {
                              onFavoriteCallback?.call(paraPharmData);
                            },
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.responsiveAppSizeTheme.current.p8,
                  horizontal: context.responsiveAppSizeTheme.current.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.bgDisabled, width: 1.2),
                          image: DecorationImage(
                            image: paraPharmData
                                        .company?.thumbnailImage?.path ==
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
                      Text(paraPharmData.company!.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                              context.responsiveTextTheme.current.body3Regular),
                    ],
                  ),
                  const ResponsiveGap.s4(),
                  Tooltip(
                    message: paraPharmData.name,
                    triggerMode: TooltipTriggerMode.longPress,
                    child: Text(paraPharmData.name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: context
                            .responsiveTextTheme.current.headLine3SemiBold
                            .copyWith(color: TextColors.primary.color)),
                  ),
                  const ResponsiveGap.s6(),
                  if (paraPharmData.tags.isNotEmpty && displayTags)
                    SilverTags(tags: paraPharmData.tags),
                  PriceWidget(
                    price: paraPharmData.unitPriceHt,
                    overridePrice: paraPharmData.computedPrice,
                    mainStyle: context
                        .responsiveTextTheme.current.headLine4SemiBold
                        .copyWith(color: AppColors.accent1Shade1),
                    currencyStyle: context
                        .responsiveTextTheme.current.bodyXSmall
                        .copyWith(color: AppColors.accent1Shade1, fontSize: 10),
                  ),
                  const ResponsiveGap.s4(),
                  PrimaryTextButton(
                      label: context.translation!.add_cart,
                      leadingIcon: Iconsax.add,
                      labelTextStyle: context
                          .responsiveTextTheme.current.body3Regular
                          .copyWith(color: Colors.white),
                      onTap: () {
                        BottomSheetHelper.showCommonBottomSheet(
                            initialChildSize: .5,
                            context: context,
                            child: QuickCartAddModal(
                              paraPharmaCatalogId: paraPharmData.id,
                              minOrderQuantity: paraPharmData.minOrderQuantity,
                              maxOrderQuantity: paraPharmData.maxOrderQuantity,
                            ));
                      },
                      color: AppColors.accent1Shade1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
