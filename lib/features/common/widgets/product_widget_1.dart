import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../chips/custom_chip.dart' show CustomChip;

class ProductWidget1 extends StatelessWidget {
  const ProductWidget1({super.key});

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
            imageUrl: "https://pharmacie-denni.dz/wp-content/uploads/2025/05/12-2-1.png",
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
                  Colors.transparent,
                  Colors.black26,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  CustomChip(label: "Antibiotic", color: AppColors.bgDarken2, onTap: () {}),
                  Spacer(),
                  CustomChip(
                      label: "In Stock",
                      icon: Iconsax.bag,
                      labelColor: AppColors.bgWhite,
                      color: SystemColors.green.primary,
                      onTap: () {})
                ]),
                Spacer(),
                Text("Amoxicillin 500mg – Capsules",
                    style: AppTypography.headLine2Style.copyWith(color: AppColors.bgWhite)),
                Gap(AppSizesManager.s12),
                Row(children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDlbus0IN1ARjIebp4zdHk_I_87kDq8Suq5A&s")),
                    ),
                  ),
                  Gap(AppSizesManager.s4),
                  Text("El Amine Biopharm", style: AppTypography.body3RegularStyle.copyWith(color: AppColors.bgWhite)),
                  Spacer(),
                  Icon(
                    Iconsax.wallet_money,
                    color: AppColors.bgWhite,
                  ),
                  Gap(AppSizesManager.s4),
                  Text("120 DZD", style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.bgWhite)),
                ])
              ],
            ),
          )
        ]));
  }
}
