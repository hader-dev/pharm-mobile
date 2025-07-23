import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../models/create_cart_item.dart';
import '../../../models/medicine_catalog.dart';
import '../../../utils/enums.dart';
import '../buttons/solid/primary_icon_button.dart' show PrimaryIconButton;

class MedicineWidget4 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  const MedicineWidget4({super.key, required this.medicineData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p12),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          GoRouter.of(context).pushNamed(RoutingManager.medicineDetailsScreen, extra: medicineData.id);
        },
        child: Column(
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizesManager.r6), topRight: Radius.circular(AppSizesManager.r6)),
                  border: medicineData.image != null
                      ? null
                      : Border.all(
                          color: AppColors.bgDisabled,
                          width: .6,
                        ),
                ),
                child: Stack(children: [
                  medicineData.image != null
                      ? CacheNetworkImagePlus(
                          boxFit: BoxFit.cover,
                          width: double.maxFinite,
                          imageUrl: "https://pharmacie-denni.dz/wp-content/uploads/2025/05/12-2-1.png",
                        )
                      : Center(
                          child: Image(
                            image: AssetImage(DrawableAssetStrings.medicinePlaceHolderImg),
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
                  Row(children: [
                    Transform.scale(
                      alignment: Alignment.topLeft,
                      scale: .8,
                      child: Container(
                        padding: EdgeInsets.all(AppSizesManager.p4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(AppSizesManager.r6),
                              topLeft: Radius.circular(AppSizesManager.r6)),
                          color: const Color.fromARGB(255, 195, 252, 222).withValues(alpha: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            medicineData.stockQuantity > 0
                                ? Icon(Iconsax.box_2,
                                    color: SystemColors.green.primary, size: AppSizesManager.iconSize16)
                                : Icon(Iconsax.box_2,
                                    color: SystemColors.red.primary, size: AppSizesManager.iconSize16),
                            const Gap(AppSizesManager.s4),
                            Text(medicineData.stockQuantity > 0 ? "In Stock" : "Out of Stock",
                                style: AppTypography.bodySmallStyle.copyWith(
                                    color: SystemColors.green.primary, fontWeight: AppTypography.appFontSemiBold)),
                          ],
                        ),
                      ),
                    ),
                    Spacer()
                  ]),
                ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppSizesManager.r6),
                  bottomRight: Radius.circular(AppSizesManager.r6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Gap(AppSizesManager.s8),
                  if (medicineData.dci != null)
                    Text(medicineData.dci,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body2MediumStyle.copyWith(color: TextColors.primary.color)),
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
                              text: double.parse(medicineData.unitPriceHt).formatAsPrice(),
                              style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
                            ),
                            TextSpan(
                              text: " ${context.translation!.currency}",
                              style: AppTypography.bodyXSmallStyle.copyWith(color: AppColors.accent1Shade1),
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
                            AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>().addToCart(
                                CreateCartItemModel(
                                    productId: medicineData.id, productType: ProductTypes.medicine, quantity: 1));
                          },
                          icon: Icon(
                            Iconsax.add,
                            color: Colors.black,
                          ),
                        ),
                      )
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
