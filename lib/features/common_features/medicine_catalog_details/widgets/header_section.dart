import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../models/medicine_catalog.dart';
import '../../../common/chips/custom_chip.dart';
import '../cubit/medicine_details_cubit.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context)
            .state
            .medicineCatalogData!;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p16, horizontal: AppSizesManager.p12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(medicineCatalogData.dci ?? "No dci Available",
              style: context.responsiveTextTheme.current.headLine2),
   const ResponsiveGap.s12(),
          IntrinsicWidth(
            child: CustomChip(
              label: medicineCatalogData.medicine.brandName,
              color: AppColors.bgDarken2,
              onTap: () {},
            ),
          ),
   const ResponsiveGap.s12(),
          Row(
            children: [
              Icon(
                Iconsax.money_4,
                color: SystemColors.defaultState.primary,
              ),
              const ResponsiveGap.s4(),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: double.parse(medicineCatalogData.unitPriceHt)
                          .formatAsPrice(),
                      style: context
                          .responsiveTextTheme.current.headLine3SemiBold
                          .copyWith(color: AppColors.accent1Shade1),
                    ),
                    TextSpan(
                      text: " ${context.translation!.currency}",
                      style: context.responsiveTextTheme.current.bodyXSmall
                          .copyWith(color: AppColors.accent1Shade1),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
