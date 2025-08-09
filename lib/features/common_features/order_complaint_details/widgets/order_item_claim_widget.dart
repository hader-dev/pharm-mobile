import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

class OrderItemClaimWidget extends StatelessWidget {
  final OrderItem item;

  const OrderItemClaimWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizesManager.p8),
                    color: item.imageUrl == null ? Colors.grey.shade100 : null,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                          '${Urls.publicFiles}${item.imageUrl}',
                        ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(width: AppSizesManager.s8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body3MediumStyle
                          .copyWith(color: Colors.grey[500]),
                      TextSpan(
                        text: "${context.translation!.quantity} ",
                        children: <InlineSpan>[
                          TextSpan(
                            text: item.quantity.toString(),
                            style: AppTypography.body3MediumStyle
                                .copyWith(color: TextColors.primary.color),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text.rich(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        text: double.parse(item.totalAmountHt.toString())
                            .formatAsPrice(),
                        style: AppTypography.body3MediumStyle,
                        children: <InlineSpan>[
                          TextSpan(
                            text:
                                ' ${RoutingManager.rootNavigatorKey.currentContext!.translation!.currency}',
                            style: AppTypography.bodySmallStyle
                                .copyWith(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
