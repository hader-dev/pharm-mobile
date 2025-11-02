import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/client.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class DeligateClientWidget extends StatelessWidget {
  const DeligateClientWidget({super.key, required this.client});
  final DeligateClient client;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        GoRouter.of(context).pushNamed(
            RoutingManager.deligateMartketPlaceScreen,
            extra: client);
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: .15,
              child: Image(
                image: client.buyerCompany.thumbnailImage?.path == null
                    ? AssetImage(DrawableAssetStrings.companyPlaceHolderImg)
                    : NetworkImage(
                        getItInstance.get<INetworkService>().getFilesPath(
                              client.buyerCompany.thumbnailImage!.path,
                            ),
                      ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
            padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  context.responsiveAppSizeTheme.current.commonWidgetsRadius),
              border: Border.all(color: StrokeColors.normal.color, width: 1),
            ),
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
                        style: context
                            .responsiveTextTheme.current.headLine4SemiBold,
                      ),
                    ),
                  ],
                ),
                const ResponsiveGap.s8(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
