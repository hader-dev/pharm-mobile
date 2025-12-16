// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hader_pharm_mobile/config/di/di.dart';
// import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
// import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
// import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
// import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
// import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
// import 'package:hader_pharm_mobile/models/client.dart';
// import 'package:hader_pharm_mobile/utils/assets_strings.dart';
// import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

// class DelegateClientWidget extends StatelessWidget {
//   const DelegateClientWidget({super.key, required this.client});
//   final DeligateClient client;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: Colors.transparent,
//       onTap: () {
//         GoRouter.of(context).pushNamed(RoutingManager.deligateMartketPlaceScreen, extra: client);
//       },
//       child: Stack(
//         children: [
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Opacity(
//               opacity: .15,
//               child: Image(
//                 image: client.buyerCompany.thumbnailImage?.path == null
//                     ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
//                     : NetworkImage(
//                         getItInstance.get<INetworkService>().getFilesPath(
//                               client.buyerCompany.thumbnailImage!.path,
//                             ),
//                       ),
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
//             padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
//               border: Border.all(color: StrokeColors.normal.color, width: 1),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         client.buyerCompany.name,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                         softWrap: true,
//                         style: context.responsiveTextTheme.current.headLine4SemiBold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const ResponsiveGap.s8(),
//                 InfoRow(
//                   label: context.translation!.address,
//                   dataValue: client.buyerCompany.address ?? "",
//                   contentDirection: Axis.vertical,
//                 ),
//                 InfoRow(
//                   label: context.translation!.phone,
//                   dataValue: client.buyerCompany.phone ?? "",
//                   contentDirection: Axis.vertical,
//                 ),
//                 InfoRow(
//                   label: context.translation!.email,
//                   dataValue: client.buyerCompany.email ?? "",
//                   contentDirection: Axis.vertical,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
import 'package:hader_pharm_mobile/models/client.dart' show DelegateClient;
import 'package:hader_pharm_mobile/models/company.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;

class DelegateClientWidget extends StatelessWidget {
  final DelegateClient client;

  const DelegateClientWidget({
    super.key,
    required this.client,
  });

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
        GoRouter.of(context).pushNamed(RoutingManager.vendorDetails, extra: client.id);
      },
      child: BlocBuilder<VendorsCubit, VendorsState>(
        builder: (context, state) {
          return Container(
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
                              child: CachedNetworkImageWithDrawableFallback.withErrorSvgImage(
                                imageUrl: getItInstance
                                    .get<INetworkService>()
                                    .getFilesPath(client.?.path ?? ''),
                              )),
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
                              client.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: context.responsiveTextTheme.current.headLine3SemiBold,
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Icon(
                                client.isLiked ?? false ? Iconsax.heart5 : Iconsax.heart,
                                color: client.isLiked ?? false ? Colors.red : Colors.grey[400],
                                size: context.responsiveAppSizeTheme.current.iconSize20,
                              ),
                            ),
                            onTap: () {
                              client.isLiked ?? false ? onRemoveFromFavorites?.call() : onLike?.call();
                            },
                          )
                        ],
                      ),
                      if (client.phone != null || client.email != null)
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.responsiveAppSizeTheme.current.p8,
                            bottom: context.responsiveAppSizeTheme.current.p8,
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            if (client.phone != null) ...[
                              InkWell(
                                onTap: () {
                                  _makePhoneCall(client.phone!);
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
                                        client.phone!,
                                        style: context.responsiveTextTheme.current.bodySmall
                                            .copyWith(color: TextColors.primary.color),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              ResponsiveGap.s8()
                            ],
                            if (client.email != null) ...[
                              InkWell(
                                onTap: () {
                                  _sendMail(client.email!);
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
                                        client.email!,
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
                      if (client.description != null) ...[
                        const ResponsiveGap.s8(),
                        Text(
                          client.description!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style:
                              context.responsiveTextTheme.current.bodySmall.copyWith(color: TextColors.ternary.color),
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
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
