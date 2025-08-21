import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../models/medicine_catalog.dart';
import '../../../../../utils/constants.dart';
import '../../cubit/medicine_details_cubit.dart';

class MedicineOverViewPage extends StatelessWidget {
  const MedicineOverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context).medicineCatalogData!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Description',
            //   style: AppTypography.headLine3SemiBoldStyle.copyWith(color: AppColors.accent1Shade1),
            // ),
            // Gap(AppSizesManager.s12),
            // Text(
            //   medicineCatalogData.
            //   style: AppTypography.body2RegularStyle,
            // ),
            // Gap(AppSizesManager.s12),
            Row(
              children: [
                Icon(Icons.check_box, color: AppColors.accentGreenShade2),
                Gap(AppSizesManager.s8),
                Text(
                  ' Caractéristiques principales',
                  style: context.responsiveTextTheme.current.headLine3SemiBold,
                ),
              ],
            ),
            Gap(AppSizesManager.s16),
            InfoRow(
              label: 'Form pharmaceutique',
              dataValue: medicineCatalogData.medicine.form,
            ),
            InfoRow(
              label: 'Dosage',
              dataValue: medicineCatalogData.medicine.dosage,
            ),
            InfoRow(
              label: 'Packaging',
              dataValue: medicineCatalogData.medicine.packaging,
            ),
            InfoRow(
              label: 'Type',
              dataValue: medicineCatalogData.medicine.type,
            ),
            InfoRow(
              label: 'Status',
              dataValue: medicineCatalogData.medicine.status,
            ),
            InfoRow(
              label: 'Life time',
              dataValue: medicineCatalogData.medicine.lifeTime,
            ),
            InfoRow(
              label: 'Laboratory',
              dataValue: medicineCatalogData.medicine.laboratoryHolder,
            ),
            InfoRow(
              label: 'Country of origin',
              dataValue: medicineCatalogData.medicine.laboratoryCountry,
            ),
          ]),
    );
  }
}
