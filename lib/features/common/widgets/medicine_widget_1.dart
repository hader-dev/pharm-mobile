import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/models/medicine_catalog.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../chips/custom_chip.dart' show CustomChip;

class MedicineWidget1 extends StatelessWidget {
  final BaseMedicineCatalogModel medicineData;
  const MedicineWidget1({super.key, required this.medicineData});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(AppSizesManager.p8),
        clipBehavior: Clip.antiAlias,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizesManager.r6),
        ),
        child: Stack(children: [
          CacheNetworkImagePlus(
            width: double.maxFinite,
            boxFit: BoxFit.cover,
            imageUrl:
                "https://images.aeonmedia.co/images/afef287f-dd6f-4a6a-b8a6-4f0a09330657/sized-kendal-l4ikccachoc-unsplash.jpg?width=3840&quality=75&format=auto",
          ),
          Container(
            padding: const EdgeInsets.all(AppSizesManager.p8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black26,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black26,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  // if (medicineData..isNotEmpty)
                  //   CustomChip(label: medicineData.brandName, color: AppColors.bgDarken2, onTap: () {}),
                  Spacer(),
                  CustomChip(
                      label: medicineData.stockQuantity > 0 ? "In Stock" : "Out of Stock",
                      icon: Iconsax.bag,
                      labelColor: AppColors.bgWhite,
                      color: SystemColors.green.primary,
                      onTap: () {})
                ]),
                Spacer(),
                if (medicineData.dci != null)
                  Text(medicineData.dci,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.headLine4SemiBoldStyle.copyWith(color: AppColors.bgWhite)),
                Gap(AppSizesManager.s12),
                Row(children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: medicineData.company?.image == null
                                ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                                : NetworkImage(medicineData.company?.thumbnailImage),
                          ))),
                  Gap(AppSizesManager.s4),
                  Spacer(),
                  Icon(
                    Iconsax.wallet_money,
                    color: AppColors.bgWhite,
                    size: AppSizesManager.iconSize18,
                  ),
                  Gap(AppSizesManager.s4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: double.parse(medicineData.unitPriceHt).formatAsPrice(),
                          style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.bgWhite),
                        ),
                        TextSpan(
                          text: " ${context.translation!.currency}",
                          style: AppTypography.bodyXSmallStyle.copyWith(color: AppColors.bgWhite),
                        ),
                      ],
                    ),
                  ),
                ])
              ],
            ),
          )
        ]));
  }
}
