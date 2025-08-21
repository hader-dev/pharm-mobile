import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../models/medicine_catalog.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import '../../cubit/medicine_details_cubit.dart';
import 'widgets/technical_specs_section.dart';

class DistributorDetailsPage extends StatelessWidget {
  const DistributorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineCatalogModel medicineCatalogData =
        BlocProvider.of<MedicineDetailsCubit>(context).medicineCatalogData!;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Description',
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.accent1Shade1),
            ),
            Gap(AppSizesManager.s12),
            Text(
              medicineCatalogData.company.description ??
                  "No description available",
              style: context.responsiveTextTheme.current.body2Regular,
            ),
            Gap(AppSizesManager.s12),
            SpecificationsWidget(
              specifications: {
                'Nom de la société': medicineCatalogData.company.name,
                'Specialty': DistributorCategory.values
                    .firstWhere((e) => e.id == medicineCatalogData.company.type)
                    .name,
                'Adresse': medicineCatalogData.company.address ??
                    "No address available",
                'Téléphone': medicineCatalogData.company.phone ??
                    "No phone number available",
                'Email':
                    medicineCatalogData.company.email ?? "No email available",
              },
            ),
          ],
        ));
  }
}
