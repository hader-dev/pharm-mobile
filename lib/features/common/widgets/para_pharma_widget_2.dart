import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/blackened_background.dart';
import 'package:hader_pharm_mobile/features/common/widgets/silver_tags.dart';
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
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
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p6, vertical: AppSizesManager.p12),
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
            Container(
              margin: const EdgeInsets.only(right: AppSizesManager.p8),
              clipBehavior: Clip.antiAlias,
              height: 120,
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
                            image: AssetImage(
                                DrawableAssetStrings.paraPharmaPlaceHolderImg),
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                  if (paraPharmData.image != null) BlackenedBackground(),
                  StockAvaillableContainerWidget(
                      isAvaillable: paraPharmData.stockQuantity > 0),
                  if (onFavoriteCallback != null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.accent1Shade1.withAlpha(150),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            paraPharmData.isLiked
                                ? Iconsax.heart5
                                : Iconsax.heart,
                            color: paraPharmData.isLiked
                                ? Colors.red
                                : Colors.black,
                            size: AppSizesManager.iconSize30,
                          ),
                        ),
                        onPressed: () {
                          onFavoriteCallback?.call(paraPharmData);
                        },
                      ),
                    )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ResponsiveGap.s8(),
                Text(paraPharmData.name,
                    softWrap: true,
                    style: context.responsiveTextTheme.current.headLine4SemiBold
                        .copyWith(color: TextColors.primary.color)),
                const ResponsiveGap.s4(),
                if (paraPharmData.tags.isNotEmpty && displayTags)
                  SilverTags(tags: paraPharmData.tags),
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
                    Spacer(),
                    if (showQuickAddButton)
                      Transform.scale(
                        scale: .6,
                        child: PrimaryIconButton(
                          isBordered: true,
                          borderColor: AppColors.accent1Shade1,
                          bgColor: Colors.transparent,
                          onPressed: () {
                            BottomSheetHelper.showCommonBottomSheet(
                                initialChildSize: .5,
                                context: context,
                                child: QuickCartAddModal(
                                  paraPharmaCatalogId: paraPharmData.id,
                                ));
                          },
                          icon: Icon(Iconsax.add,
                              color: Colors.black,
                              size: AppSizesManager.iconSize30),
                        ),
                      )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
