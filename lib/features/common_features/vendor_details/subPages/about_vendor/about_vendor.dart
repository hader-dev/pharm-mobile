import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';


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
              context.translation!.description,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.accent1Shade1),
            ),
            Gap(AppSizesManager.s12),
            Text(
              vendorData.description ?? context.translation!.no_description_available,
              style: context.responsiveTextTheme.current.body2Regular,
            ),
            Gap(AppSizesManager.s12),
            SpecificationsWidget(
              specifications: {
                context.translation!.company_name: vendorData.name,
                context.translation!.specialty: DistributorCategory.values
                    .firstWhere((e) => e.id == vendorData.type)
                    .name,
                context.translation!.address: vendorData.address ?? context.translation!.no_address_available,
                context.translation!.phone: vendorData.phone ?? context.translation!.no_phone_available,
                context.translation!.email: vendorData.email ?? context.translation!.no_email_available,
              },
            ),
          ],
        ));
  }
}
