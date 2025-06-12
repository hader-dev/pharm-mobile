import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../chips/custom_chip.dart' show CustomChip;

class ProductWidget2 extends StatelessWidget {
  const ProductWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p8),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: AppSizesManager.p8),
              clipBehavior: Clip.antiAlias,
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesManager.r6),
              ),
              child: Stack(children: [
                CacheNetworkImagePlus(
                  boxFit: BoxFit.cover,
                  imageUrl: "https://pharmacie-denni.dz/wp-content/uploads/2025/05/12-2-1.png",
                ),
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
                      color: const Color.fromARGB(255, 195, 252, 222).withValues(alpha: 0.8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Iconsax.box_2, color: SystemColors.green.primary, size: AppSizesManager.iconSize16),
                        const Gap(AppSizesManager.s4),
                        Text("In Stock",
                            style: AppTypography.bodySmallStyle.copyWith(
                                color: SystemColors.green.primary, fontWeight: AppTypography.appFontSemiBold)),
                      ],
                    ),
                  ),
                )
              ])),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  CustomChip(label: "Antibiotic", color: AppColors.bgDarken2, onTap: () {}),
                  Spacer(),
                  Icon(Iconsax.heart, color: Colors.black54),
                ]),
                Gap(AppSizesManager.s8),
                Text("Amoxicillin 500mg – Capsules",
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headLine4SemiBoldStyle.copyWith(color: TextColors.primary.color)),
                Gap(AppSizesManager.s8),
                Row(children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDlbus0IN1ARjIebp4zdHk_I_87kDq8Suq5A&s")),
                    ),
                  ),
                  Gap(AppSizesManager.s4),
                  Text("El Amine Biopharm",
                      style: AppTypography.body3MediumStyle.copyWith(color: TextColors.primary.color)),
                ]),
                Row(
                  children: [
                    Icon(
                      Iconsax.wallet_money,
                      color: AppColors.accent1Shade1,
                    ),
                    Gap(AppSizesManager.s4),
                    Text("120 DZD",
                        style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
