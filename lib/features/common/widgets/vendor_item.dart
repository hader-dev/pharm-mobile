import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../config/theme/colors_manager.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/enums.dart';

class VendorItem extends StatelessWidget {
  final bool hideRemoveButton;
  final VoidCallback? onRemoveFromFavorites;

  final Company companyData;
  late final DistributorCategory distributorCategory;
  VendorItem({
    super.key,
    required this.companyData,
    this.hideRemoveButton = true,
    this.onRemoveFromFavorites,
  }) {
    distributorCategory = DistributorCategory.values.firstWhere(
        (element) => element.id == companyData.distributorCategory,
        orElse: () => DistributorCategory.both);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RoutingManager.vendorDetails, extra: companyData.id);
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: .15,
              child: Image(
                  image: companyData.thumbnailImage?.path == null
                      ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                      : NetworkImage(
                                  getItInstance
                                      .get<INetworkService>()
                                      .getFilesPath(
                                        companyData.thumbnailImage!
                                            .path,
                                      ),),),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(AppSizesManager.p12),
            padding: EdgeInsets.all(AppSizesManager.p8),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
              border: Border.all(color: StrokeColors.normal.color, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!hideRemoveButton)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSizesManager.p4),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: onRemoveFromFavorites,
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: AppSizesManager.iconSize16,
                        ),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        companyData.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: context
                            .responsiveTextTheme.current.headLine4SemiBold,
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
                              style: context
                                  .responsiveTextTheme.current.bodySmall
                                  .copyWith(
                                      color: distributorCategory.color,
                                      fontWeight: context.responsiveTextTheme
                                          .current.appFont.appFontSemiBold)),
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
