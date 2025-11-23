import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'widgets/technical_specs_section.dart';

class VendorDetailsPage extends StatelessWidget {
  final Company vendorData;
  const VendorDetailsPage({super.key, required this.vendorData});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.responsiveAppSizeTheme.current.p8,
            horizontal: context.responsiveAppSizeTheme.current.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SpecificationsWidget(
              specifications: {
                context.translation!.company_name: vendorData.name,
                context.translation!.description: vendorData.description ??
                    context.translation!.no_description_available,
                context.translation!.specialty: DistributorCategory.values
                    .firstWhere((e) => e.id == vendorData.type)
                    .name,
                context.translation!.address: vendorData.address ??
                    context.translation!.no_address_available,
                context.translation!.phone:
                    vendorData.phone ?? context.translation!.no_phone_available,
                context.translation!.email:
                    vendorData.email ?? context.translation!.no_email_available,
              },
            ),
          ],
        ));
  }
}
