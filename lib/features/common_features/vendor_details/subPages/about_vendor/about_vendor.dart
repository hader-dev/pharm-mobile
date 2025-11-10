import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
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
            vertical: context.responsiveAppSizeTheme.current.p24,
            horizontal: context.responsiveAppSizeTheme.current.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Container(
                height: context.responsiveAppSizeTheme.current.iconSize48,
                width: context.responsiveAppSizeTheme.current.iconSize48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.bgDisabled, width: 1.5),
                  image: DecorationImage(
                    image: vendorData.image?.path == null
                        ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                        : NetworkImage(getItInstance
                                .get<INetworkService>()
                                .getFilesPath(vendorData.image?.path ?? ''))
                            as ImageProvider,
                  ),
                ),
              ),
              const ResponsiveGap.s8(),
              Text(vendorData.name,
                  style: context.responsiveTextTheme.current.headLine4SemiBold
                      .copyWith(
                          color: AppColors.accent1Shade1,
                          overflow: TextOverflow.ellipsis))
            ]),
            const ResponsiveGap.s12(),
            Text(
              context.translation!.description,
              style: context.responsiveTextTheme.current.headLine3SemiBold
                  .copyWith(color: AppColors.accent1Shade1),
            ),
            const ResponsiveGap.s12(),
            Text(
              vendorData.description ??
                  context.translation!.no_description_available,
              style: context.responsiveTextTheme.current.body2Regular,
            ),
            const ResponsiveGap.s12(),
            SpecificationsWidget(
              specifications: {
                context.translation!.company_name: vendorData.name,
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
