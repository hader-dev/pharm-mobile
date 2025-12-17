// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hader_pharm_mobile/config/di/di.dart';
// import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
// import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
// import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
// import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
// import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
// import 'package:hader_pharm_mobile/models/client.buyerCompany.dart';
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
//                 image: client.buyerCompany.buyerCompany.thumbnailImage?.path == null
//                     ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
//                     : NetworkImage(
//                         getItInstance.get<INetworkService>().getFilesPath(
//                               client.buyerCompany.buyerCompany.thumbnailImage!.path,
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
//                         client.buyerCompany.buyerCompany.name,
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
//                   dataValue: client.buyerCompany.buyerCompany.address ?? "",
//                   contentDirection: Axis.vertical,
//                 ),
//                 InfoRow(
//                   label: context.translation!.phone,
//                   dataValue: client.buyerCompany.buyerCompany.phone ?? "",
//                   contentDirection: Axis.vertical,
//                 ),
//                 InfoRow(
//                   label: context.translation!.email,
//                   dataValue: client.buyerCompany.buyerCompany.email ?? "",
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
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';

import 'package:hader_pharm_mobile/models/client.dart' show DelegateClient;
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../common/image/cached_network_image_with_asset_fallback.dart'
    show CachedNetworkImageWithDrawableFallback;
import '../../../common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart' show InfoRow;
import '../cubit/delegate_clients_cubit.dart' show DelegateClientsCubit, DelegateClientsState;

class DelegateClientWidget extends StatelessWidget {
  final DelegateClient client;

  const DelegateClientWidget({
    super.key,
    required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(RoutingManager.delegateMarketPlaceScreen, extra: client);
      },
      child: BlocBuilder<DelegateClientsCubit, DelegateClientsState>(
        builder: (context, state) {
          return Container(
              margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
                border: Border.all(color: StrokeColors.normal.color, width: 1),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                                    .getFilesPath(client.buyerCompany.thumbnailImage?.path ?? ''),
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
                                client.buyerCompany.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: context.responsiveTextTheme.current.headLine3SemiBold,
                              ),
                            ),
                          ],
                        ),
                        if (client.buyerCompany.phone != null || client.buyerCompany.email != null)
                          Padding(
                            padding: EdgeInsets.only(
                              top: context.responsiveAppSizeTheme.current.p4,
                              bottom: context.responsiveAppSizeTheme.current.p4,
                            ),
                            child: Column(
                              spacing: context.responsiveAppSizeTheme.current.s2,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoRow(
                                  label: context.translation!.address,
                                  dataValue: client.buyerCompany.address ?? "",
                                  contentDirection: Axis.vertical,
                                ),
                                InfoRow(
                                  label: context.translation!.phone,
                                  dataValue: client.buyerCompany.phone ?? "",
                                  contentDirection: Axis.vertical,
                                ),
                                InfoRow(
                                  label: context.translation!.email,
                                  dataValue: client.buyerCompany.email ?? "",
                                  contentDirection: Axis.vertical,
                                ),
                                ResponsiveGap.s4(),
                                InkWell(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Spacer(),
                                      Text(
                                        "browse",
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
                    ))
              ]));
        },
      ),
    );
  }
}
