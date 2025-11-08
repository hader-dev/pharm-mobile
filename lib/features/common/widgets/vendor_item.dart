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
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

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
        margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          border: Border.all(color: StrokeColors.normal.color, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.maxHeight.isFinite
                      ? constraints.maxHeight
                      : constraints.maxWidth;
                  return Center(
                    child: ClipOval(
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: companyData.thumbnailImage?.path == null
                            ? Image.asset(
                                DrawableAssetStrings.companyPlaceHolderImg,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                getItInstance
                                    .get<INetworkService>()
                                    .getFilesPath(
                                        companyData.thumbnailImage!.path),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                      child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    DrawableAssetStrings.companyPlaceHolderImg,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const ResponsiveGap.s12(),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyData.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style:
                        context.responsiveTextTheme.current.headLine4SemiBold,
                  ),
                  const ResponsiveGap.s12(),
                  InfoRow(
                    icon: Iconsax.location,
                    dataValue: companyData.address ?? "",
                    contentDirection: Axis.horizontal,
                  ),
                  InfoRow(
                    icon: Icons.phone,
                    dataValue: companyData.phone ?? "",
                    contentDirection: Axis.horizontal,
                  ),
                  InfoRow(
                    icon: Icons.email,
                    dataValue: companyData.email ?? "",
                    contentDirection: Axis.horizontal,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
