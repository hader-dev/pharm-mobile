import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/routes/routing_manager.dart';
import '../../../config/theme/colors_manager.dart';
import '../../../models/create_cart_item.dart';
import '../../../utils/enums.dart';
import '../../app_layout/app_layout.dart';
import '../../common_features/cart/cubit/cart_cubit.dart';
import '../buttons/solid/primary_icon_button.dart';

typedef OnFavoriteCallback = void Function(BaseParaPharmaCatalogModel medicine);

class ParaPharmaWidget2 extends StatelessWidget {
  final BaseParaPharmaCatalogModel paraPharmData;
  final OnFavoriteCallback? onFavoriteCallback;

  const ParaPharmaWidget2(
      {super.key, required this.paraPharmData, this.onFavoriteCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizesManager.p6, vertical: AppSizesManager.p12),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pushNamed(RoutingManager.paraPharmaDetailsScreen,
              extra: paraPharmData.id);
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
                child: Stack(children: [
                  paraPharmData.image != null
                      ? CacheNetworkImagePlus(
                          boxFit: BoxFit.cover,
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
                          paraPharmData.stockQuantity > 0
                              ? Icon(Iconsax.box_2,
                                  color: SystemColors.green.primary,
                                  size: AppSizesManager.iconSize16)
                              : Icon(Iconsax.box_2,
                                  color: SystemColors.red.primary,
                                  size: AppSizesManager.iconSize16),
                          const Gap(AppSizesManager.s4),
                          Text(
                              paraPharmData.stockQuantity > 0
                                  ? context.translation!.in_stock
                                  : context.translation!.out_stock,
                              style: context
                                  .responsiveTextTheme.current.bodySmall
                                  .copyWith(
                                      color: SystemColors.green.primary,
                                      fontWeight: context.responsiveTextTheme
                                          .current.appFont.appFontSemiBold)),
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
                ])),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(AppSizesManager.s8),
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
                Text(paraPharmData.name,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: context.responsiveTextTheme.current.headLine4SemiBold
                        .copyWith(color: TextColors.primary.color)),
                Gap(AppSizesManager.s4),
                Row(
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
                    Transform.scale(
                      scale: .6,
                      child: PrimaryIconButton(
                        isBordered: true,
                        borderColor: AppColors.accent1Shade1,
                        bgColor: Colors.transparent,
                        onPressed: () {
                          AppLayout.appLayoutScaffoldKey.currentContext!
                              .read<CartCubit>()
                              .addToCart(
                                  CreateCartItemModel(
                                      productId: paraPharmData.id,
                                      productType: ProductTypes.para_pharmacy,
                                      quantity: 1),
                                  true);
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
