import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../models/create_cart_item.dart';
import '../../../models/medicine_catalog.dart';
import '../../../utils/enums.dart';
import '../buttons/solid/primary_icon_button.dart' show PrimaryIconButton;

typedef OnFavoriteCallback = void Function(BaseMedicineCatalogModel medicine);

class MedicineWidget3 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  final OnFavoriteCallback? onFavoriteCallback;
  const MedicineWidget3(
      {super.key, required this.medicineData, this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p6, vertical: AppSizesManager.p12),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          GoRouter.of(context).pushNamed(RoutingManager.medicineDetailsScreen,
              extra: medicineData.id);
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
                // Gap(AppSizesManager.s8), not implemented on api ? no such information
                // Row(children: [
                //   Transform.scale(
                //       alignment: Alignment.centerLeft,
                //       scale: .9,
                //       child: CustomChip(
                //           label: "Antibiotic",
                //           color: AppColors.bgDarken2,
                //           onTap: () {})),
                //   Spacer()
                // ]),
                Gap(AppSizesManager.s8),
                if (medicineData.dci != null)
                  Text(medicineData.dci,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: context
                          .responsiveTextTheme.current.headLine4SemiBold
                          .copyWith(color: TextColors.primary.color)),
                Gap(AppSizesManager.s4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Icon(
                      Iconsax.wallet_money,
                      color: AppColors.accent1Shade1,
                      size: AppSizesManager.iconSize18,
                    ),
                    Gap(AppSizesManager.s4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: double.parse(medicineData.unitPriceHt)
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
                    Transform.scale(
                      scale: .55,
                      child: PrimaryIconButton(
                        isBordered: true,
                        borderColor: AppColors.accent1Shade1,
                        bgColor: Colors.transparent,
                        onPressed: () {
                          AppLayout.appLayoutScaffoldKey.currentContext!
                              .read<CartCubit>()
                              .addToCart(CreateCartItemModel(
                                  productId: medicineData.id,
                                  productType: ProductTypes.medicine,
                                  quantity: 1));
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
                boxFit: BoxFit.cover,
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
                  height: 80,
                  width: 80,
                ),
              ),
        if (medicineData.image != null)
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
        Transform.scale(
          alignment: Alignment.topLeft,
          scale: .8,
          child: Container(
            padding: EdgeInsets.all(AppSizesManager.p4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(AppSizesManager.r6),
                  topLeft: Radius.circular(AppSizesManager.r6)),
              color: const Color.fromARGB(255, 195, 252, 222)
                  .withValues(alpha: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                medicineData.stockQuantity > 0
                    ? Icon(Iconsax.box_2,
                        color: SystemColors.green.primary,
                        size: AppSizesManager.iconSize16)
                    : Icon(Iconsax.box_2,
                        color: SystemColors.red.primary,
                        size: AppSizesManager.iconSize16),
                const Gap(AppSizesManager.s4),
                Text(
                    medicineData.stockQuantity > 0
                        ? context.translation!.in_stock
                        : context.translation!.out_stock,
                    style: context.responsiveTextTheme.current.bodySmall
                        .copyWith(
                            color: SystemColors.green.primary,
                            fontWeight: context.responsiveTextTheme.current
                                .appFont.appFontSemiBold)),
              ],
            ),
          ),
        ),
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
