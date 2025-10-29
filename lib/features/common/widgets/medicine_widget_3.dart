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
import 'package:hader_pharm_mobile/features/common/widgets/stock_availlable.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

typedef OnFavoriteCallback = void Function(BaseMedicineCatalogModel medicine);

class MedicineWidget3 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  final OnFavoriteCallback? onFavoriteCallback;
  final String route;
  const MedicineWidget3(
      {super.key,
      this.route = RoutingManager.medicineDetailsScreen,
      required this.medicineData,
      this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p6, vertical: AppSizesManager.p12),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          final userRole = getItInstance.get<UserManager>().currentUser.role;
          final canOrderBasedOnRole = !userRole.isDelegate;
          GoRouter.of(context).pushNamed(route,
              extra: {"id": medicineData.id, "canOrder": canOrderBasedOnRole});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _ImageSection(
                medicineData: medicineData,
                onFavoriteCallback: onFavoriteCallback),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ResponsiveGap.s8(),
                if (medicineData.dci != null)
                  Text(medicineData.dci,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: context
                          .responsiveTextTheme.current.headLine4SemiBold
                          .copyWith(color: TextColors.primary.color)),
                const ResponsiveGap.s4(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    const Icon(
                      Iconsax.wallet_money,
                      color: AppColors.accent1Shade1,
                      size: AppSizesManager.iconSize18,
                    ),
                    const ResponsiveGap.s4(),
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
                    const Spacer(),
                    Transform.scale(
                      scale: .55,
                      child: PrimaryIconButton(
                        isBordered: true,
                        borderColor: AppColors.accent1Shade1,
                        bgColor: Colors.transparent,
                        onPressed: () {
                          BottomSheetHelper.showCommonBottomSheet(
                              initialChildSize: .5,
                              context: context,
                              child: QuickCartAddModal(
                                medicineCatalogId: medicineData.id,
                              ));
                        },
                        icon: Icon(
                          Iconsax.add,
                          color: Colors.black,
                          size: AppSizesManager.iconSize30,
                        ),
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

class _ImageSection extends StatelessWidget {
  const _ImageSection({
    required this.medicineData,
    required this.onFavoriteCallback,
  });

  final BaseMedicineCatalogModel medicineData;
  final OnFavoriteCallback? onFavoriteCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppSizesManager.p8),
      clipBehavior: Clip.antiAlias,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizesManager.r6),
        border: medicineData.image != null
            ? null
            : Border.all(
                color: AppColors.bgDisabled,
              ),
      ),
      child: Stack(children: [
        medicineData.image != null
            ? CacheNetworkImagePlus(
                boxFit: BoxFit.contain,
                width: double.maxFinite,
                height: double.maxFinite,
                imageUrl: getItInstance
                    .get<INetworkService>()
                    .getFilesPath(medicineData.image?.path ?? ''),
              )
            : Center(
                child: Image(
                  image:
                      AssetImage(DrawableAssetStrings.medicinePlaceHolderImg),
                  fit: BoxFit.cover,
                  height: 120,
                  width: 80,
                ),
              ),
        if (medicineData.image != null) BlackenedBackground(),
        StockAvaillableContainerWidget(
            isAvaillable: medicineData.stockQuantity > 0),
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
                  medicineData.isLiked ? Iconsax.heart5 : Iconsax.heart,
                  color: medicineData.isLiked ? Colors.red : Colors.black,
                  size: AppSizesManager.iconSize30,
                ),
              ),
              onPressed: () {
                onFavoriteCallback?.call(medicineData);
              },
            ),
          )
      ]),
    );
  }
}
