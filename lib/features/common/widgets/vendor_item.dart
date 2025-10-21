import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class VendorItem extends StatelessWidget {
  final bool hideLikeButton;
  final VoidCallback? onLike;
  final bool isLiked;
  final bool hideRemoveButton;
  final VoidCallback? onRemoveFromFavorites;

  final Company companyData;
  late final DistributorCategory distributorCategory;
  VendorItem({
    super.key,
    required this.companyData,
    this.hideLikeButton = true,
    this.onLike,
    this.isLiked = false,
    this.hideRemoveButton = true,
    this.onRemoveFromFavorites,
  }) {
    distributorCategory = DistributorCategory.values.firstWhere(
        (element) => element.id == companyData.distributorCategory,
        orElse: () => DistributorCategory.Both);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context)
            .pushNamed(RoutingManager.vendorDetails, extra: companyData.id);
      },
      child: Container(
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
            if (!hideLikeButton)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizesManager.p4),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: onLike,
                    child: !isLiked
                        ? Icon(Icons.favorite_border_rounded,
                            color: Colors.black54)
                        : Icon(Icons.favorite, color: Colors.red),
                  ),
                ),
              ),
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
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.accent1Shade2, width: 1.5),
                    image: DecorationImage(
                      image: companyData.thumbnailImage?.path == null
                          ? AssetImage(
                                  DrawableAssetStrings.companyPlaceHolderImg)
                              as ImageProvider
                          : NetworkImage(
                              getItInstance.get<INetworkService>().getFilesPath(
                                    companyData.thumbnailImage!.path,
                                  ),
                            ),
                    ),
                  ),
                ),
                const ResponsiveGap.s8(),
                Expanded(
                  child: Text(
                    companyData.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style:
                        context.responsiveTextTheme.current.headLine4SemiBold,
                  ),
                ),
              ],
            ),
            const ResponsiveGap.s8(),
            InfoRow(
              label: context.translation!.address,
              dataValue: companyData.address ?? "",
              contentDirection: Axis.vertical,
            ),
            InfoRow(
              label: context.translation!.phone,
              dataValue: companyData.phone ?? "",
              contentDirection: Axis.vertical,
            ),
            InfoRow(
              label: context.translation!.email,
              dataValue: companyData.email ?? "",
              contentDirection: Axis.vertical,
            ),
          ],
        ),
      ),
    );
  }
}
