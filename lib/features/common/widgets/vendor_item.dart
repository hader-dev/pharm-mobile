import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review&submit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../config/theme/typoghrapy_manager.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/enums.dart';

class VendorItem extends StatelessWidget {
  final Company companyData;
  late final DistributorCategory distributorCategory;
  VendorItem({
    super.key,
    required this.companyData,
  }) {
    distributorCategory = DistributorCategory.values
        .firstWhere((element) => element.id == companyData.distributorCategory, orElse: () => DistributorCategory.both);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(RoutingManager.vendorDetails, extra: companyData);
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: .15,
              child: Image(
                  image: companyData.image == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(companyData.image.thumbnailImage)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(AppSizesManager.p12),
            padding: EdgeInsets.all(AppSizesManager.p8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              border: Border.all(color: StrokeColors.normal.color, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        companyData.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: AppTypography.headLine4SemiBoldStyle,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(AppSizesManager.p6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(AppSizesManager.r6),
                            topLeft: Radius.circular(AppSizesManager.r6)),
                        color: distributorCategory.color.withAlpha(50),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              distributorCategory == DistributorCategory.both
                                  ? "pharmacy,para-pharmacy"
                                  : distributorCategory.name,
                              style: AppTypography.bodySmallStyle.copyWith(
                                  color: distributorCategory.color, fontWeight: AppTypography.appFontSemiBold)),
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(AppSizesManager.s8),
                InfoRow(
                  label: "Address",
                  dataValue: companyData.address ?? "",
                  contentDirection: Axis.vertical,
                ),
                InfoRow(
                  label: "Phone",
                  dataValue: companyData.phone ?? "",
                  contentDirection: Axis.vertical,
                ),
                InfoRow(
                  label: "Email",
                  dataValue: companyData.email ?? "",
                  contentDirection: Axis.vertical,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
