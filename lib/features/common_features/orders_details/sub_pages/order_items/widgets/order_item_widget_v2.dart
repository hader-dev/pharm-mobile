import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class OrderItemWidgetV2 extends StatelessWidget {
  final OrderItem item;

  const OrderItemWidgetV2({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: context.responsiveAppSizeTheme.current.p8,
        horizontal: context.responsiveAppSizeTheme.current.p4,
      ),
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(
          context.responsiveAppSizeTheme.current.commonWidgetsRadius,
        ),
      ),
      child: IntrinsicHeight(
        // 👈 ensures equal height between image + text
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // fills available height
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                context.responsiveAppSizeTheme.current.p8,
              ),
              child: CachedNetworkImageWithAssetFallback(
                assetImage: DrawableAssetStrings.medicinePlaceHolderImg,
                imageUrl: item.imageUrl != null
                    ? getItInstance
                        .get<INetworkService>()
                        .getFilesPath(item.imageUrl!)
                    : "",
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const ResponsiveGap.s8(),
            // 🧠 Do not use Expanded inside Column here
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // prevents unbounded height
                children: [
                  Text.rich(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    TextSpan(
                      text: item.designation ?? context.translation!.unknown,
                      style:
                          context.responsiveTextTheme.current.headLine4SemiBold,
                      children: <InlineSpan>[
                        TextSpan(
                          text: " x ",
                          style: context.responsiveTextTheme.current.bodySmall
                              .copyWith(color: Colors.grey[500]),
                        ),
                        TextSpan(
                          text: item.quantity.toString(),
                          style: context
                              .responsiveTextTheme.current.headLine4Medium,
                        ),
                      ],
                    ),
                  ),
                  const ResponsiveGap.s8(),
                  Text.rich(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      text: item.totalAmountHt.formatAsPrice(),
                      style: context.responsiveTextTheme.current.body3Medium,
                      children: <InlineSpan>[
                        TextSpan(
                          text: ' ${context.translation!.currency}',
                          style: context.responsiveTextTheme.current.bodySmall
                              .copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
