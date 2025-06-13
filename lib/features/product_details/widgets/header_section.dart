import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../common/chips/custom_chip.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CustomChip(label: "Antibiotic", color: AppColors.bgDarken2, onTap: () {}),
            Spacer(),
            Icon(
              Iconsax.calendar_1,
              color: SystemColors.defaultState.primary,
            ),
            Gap(AppSizesManager.s4),
            Text("20 Mai 2025", style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color)),
          ]),
          Gap(AppSizesManager.s12),
          Text("Amoxicillin 500mg – Capsules", style: AppTypography.headLine2Style),
          Gap(AppSizesManager.s12),
          Row(
            children: [
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
              Text("El Amine Biopharm", style: AppTypography.body3RegularStyle),
              Spacer(),
              Icon(
                Iconsax.money_4,
                color: SystemColors.defaultState.primary,
              ),
              Gap(AppSizesManager.s4),
              Text("120 DZD", style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1)),
            ],
          ),
        ],
      ),
    );
  }
}
