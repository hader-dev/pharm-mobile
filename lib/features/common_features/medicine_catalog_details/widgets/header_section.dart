import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_date_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../config/theme/typoghrapy_manager.dart';

import '../../../../models/medicine_catalog.dart';
import '../../../../utils/assets_strings.dart';
import '../../../common/chips/custom_chip.dart';
import '../cubit/medicine_details_cubit.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData = BlocProvider.of<MedicineDetailsCubit>(context).medicineCatalogData!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            CustomChip(label: medicineCatalogData.medicine.brandName, color: AppColors.bgDarken2, onTap: () {}),
            Spacer(),
            Icon(
              Iconsax.calendar_1,
              color: SystemColors.defaultState.primary,
            ),
            Gap(AppSizesManager.s4),
            Text(medicineCatalogData.createdAt.formatYMD,
                style: AppTypography.body3MediumStyle.copyWith(color: TextColors.ternary.color)),
          ]),
          Gap(AppSizesManager.s12),
          Text(medicineCatalogData.dci ?? "No dci Available", style: AppTypography.headLine2Style),
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
                    image: medicineCatalogData.company.image == null
                        ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                        : NetworkImage(medicineCatalogData.company.thumbnailImage),
                  ),
                ),
              ),
              Gap(AppSizesManager.s4),
              Text(medicineCatalogData.company.name, style: AppTypography.body3RegularStyle),
              Spacer(),
              Icon(
                Iconsax.money_4,
                color: SystemColors.defaultState.primary,
              ),
              Gap(AppSizesManager.s4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: double.parse(medicineCatalogData.unitPriceHt).formatAsPrice(),
                      style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
                    ),
                    TextSpan(
                      text: " ${context.translation!.currency}",
                      style: AppTypography.bodyXSmallStyle.copyWith(color: AppColors.accent1Shade1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
