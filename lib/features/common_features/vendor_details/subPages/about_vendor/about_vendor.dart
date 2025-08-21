import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../../config/theme/colors_manager.dart';
import '../../../../../models/company.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/enums.dart';
import 'widgets/technical_specs_section.dart';

class VendorDetailsPage extends StatelessWidget {
  final Company vendorData;
  const VendorDetailsPage({super.key, required this.vendorData});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppSizesManager.p24, horizontal: AppSizesManager.p16),
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
              vendorData.description ?? "No description available",
              style: context.responsiveTextTheme.current.body2Regular,
            ),
            Gap(AppSizesManager.s12),
            SpecificationsWidget(
              specifications: {
                'Nom de la société': vendorData.name,
                'Specialty': DistributorCategory.values
                    .firstWhere((e) => e.id == vendorData.type)
                    .name,
                'Adresse': vendorData.address ?? "No address available",
                'Téléphone': vendorData.phone ?? "No phone number available",
                'Email': vendorData.email ?? "No email available",
              },
            ),
          ],
        ));
  }
}
