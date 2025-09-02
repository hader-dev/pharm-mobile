import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/widgets/quick_add_modal.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../buttons/solid/primary_icon_button.dart' show PrimaryIconButton;

class MedicineWidget4 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  const MedicineWidget4({super.key, required this.medicineData});

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
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSizesManager.r6),
                      topRight: Radius.circular(AppSizesManager.r6)),
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
                          height: double.maxFinite,
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
                    Spacer()
                  ]),
                ])),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizesManager.p6, vertical: AppSizesManager.p4),
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
                        style: context.responsiveTextTheme.current.body2Medium
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
                            BottomSheetHelper.showCommonBottomSheet(
                                initialChildSize: .3,
                                context: context,
                                child: QuickCartAddModal(
                                  medicineCatalogId: medicineData.id,
                                ));
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
