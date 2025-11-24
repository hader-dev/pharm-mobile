import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/chips/custom_chip.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/vendors/cubit/vendors_cubit.dart';
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
    distributorCategory = DistributorCategory.values
        .firstWhere((element) => element.id == companyData.distributorCategory, orElse: () => DistributorCategory.Both);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendMail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(RoutingManager.vendorDetails, extra: companyData.id);
      },
      child: Container(
        margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
        padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
          border: Border.all(color: StrokeColors.normal.color, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.maxHeight.isFinite ? constraints.maxHeight : constraints.maxWidth;
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
                                getItInstance.get<INetworkService>().getFilesPath(companyData.thumbnailImage!.path),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          companyData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: context.responsiveTextTheme.current.headLine3SemiBold,
                        ),
                      ),
                      BlocBuilder<VendorsCubit, VendorsState>(
                        builder: (context, state) {
                          return InkWell(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                companyData.isLiked ?? false ? Iconsax.heart5 : Iconsax.heart,
                                color: companyData.isLiked ?? false ? Colors.red : Colors.grey[400],
                                size: context.responsiveAppSizeTheme.current.iconSize20,
                              ),
                            ),
                            onTap: () {
                              companyData.isLiked ?? false ? onRemoveFromFavorites?.call() : onLike?.call();
                            },
                          );
                        },
                      )
                    ],
                  ),
                  if (companyData.phone != null || companyData.email != null)
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.responsiveAppSizeTheme.current.p8,
                        bottom: context.responsiveAppSizeTheme.current.p8,
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (companyData.phone != null) ...[
                          InkWell(
                            onTap: () {
                              _makePhoneCall(companyData.phone!);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                              child: Row(
                                children: [
                                  Icon(
                                    Iconsax.call,
                                    size: context.responsiveAppSizeTheme.current.iconSize18,
                                    color: AppColors.accent1Shade1.withAlpha(130),
                                  ),
                                  ResponsiveGap.s12(),
                                  Text(
                                    companyData.phone!,
                                    style: context.responsiveTextTheme.current.bodySmall
                                        .copyWith(color: TextColors.primary.color),
                                  )
                                ],
                              ),
                            ),
                          ),
                          ResponsiveGap.s8()
                        ],
                        if (companyData.email != null) ...[
                          InkWell(
                            onTap: () {
                              _sendMail(companyData.email!);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p4),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.mailOpen,
                                    size: context.responsiveAppSizeTheme.current.iconSize18,
                                    color: AppColors.accent1Shade1.withAlpha(130),
                                  ),
                                  ResponsiveGap.s12(),
                                  Text(
                                    companyData.email!,
                                    style: context.responsiveTextTheme.current.bodySmall
                                        .copyWith(color: TextColors.primary.color),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]
                      ]),
                    ),

                  if (companyData.description != null) ...[
                    const ResponsiveGap.s8(),
                    Text(
                      companyData.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: true,
                      style: context.responsiveTextTheme.current.bodySmall.copyWith(color: TextColors.ternary.color),
                    ),
                  ],
                  const ResponsiveGap.s12(),
                  distributorCategory != DistributorCategory.Both
                      ? Row(
                          children: [
                            CustomChip(
                                label: distributorCategory.displayName(context.translation!),
                                labelColor: distributorCategory.color,
                                labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                    fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                    color: distributorCategory.color),
                                color: distributorCategory.color.withAlpha(50)),
                            Spacer()
                          ],
                        )
                      : Row(
                          children: [
                            CustomChip(
                                label: DistributorCategory.Pharmacy.displayName(context.translation!),
                                labelColor: distributorCategory.color,
                                labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                    fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                    color: distributorCategory.color),
                                color: distributorCategory.color.withAlpha(50)),
                            ResponsiveGap.s12(),
                            CustomChip(
                                label: DistributorCategory.ParaPharmacy.displayName(context.translation!),
                                labelColor: distributorCategory.color,
                                labelStyle: context.responsiveTextTheme.current.bodyXSmall.copyWith(
                                    fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                                    color: distributorCategory.color),
                                color: distributorCategory.color.withAlpha(50)),
                            Spacer()
                          ],
                        ),
                  ResponsiveGap.s8(),
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                          'Explore',
                          style: context.responsiveTextTheme.current.body3Medium.copyWith(
                            color: AppColors.accent1Shade1,
                            fontWeight: context.responsiveTextTheme.current.appFont.appFontBold,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_sharp,
                          color: AppColors.accent1Shade1,
                          size: context.responsiveAppSizeTheme.current.iconSize20,
                        ),
                      ],
                    ),
                  )

                  // InfoRow(
                  //   dataValue: companyData.phone ?? "",
                  //   contentDirection: Axis.horizontal,
                  // ),
                  // InfoRow(
                  //   icon: Icons.email,
                  //   dataValue: companyData.email ?? "",
                  //   contentDirection: Axis.horizontal,
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
