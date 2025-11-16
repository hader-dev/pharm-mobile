import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart' show CacheNetworkImagePlus;
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/responsive/typography/app_typography.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/image/cached_network_image_with_asset_fallback.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
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
      height: 100,
      width: double.maxFinite,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: context.responsiveAppSizeTheme.current.p6,
                vertical: context.responsiveAppSizeTheme.current.p6),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.r6),
              border: item.imageUrl != null
                  ? null
                  : Border.all(
                      color: const Color.fromARGB(197, 245, 245, 245),
                    ),
            ),
            child: item.imageUrl != null
                ? CacheNetworkImagePlus(
                    boxFit: BoxFit.contain,
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(item.imageUrl ?? ''),
                  )
                : Center(
                    child: Image(
                      image: AssetImage(
                        item.medicineCatalogId != null
                            ? DrawableAssetStrings.medicinePlaceHolderImg
                            : DrawableAssetStrings.paraPharmaPlaceHolderImg,
                      ),
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                  ),
          ),
          const ResponsiveGap.s6(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.designation ?? context.translation!.unknown,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: context.responsiveTextTheme.current.headLine4SemiBold,
                ),
                const ResponsiveGap.s8(),
                Text.rich(TextSpan(
                  text: item.unitPriceHt.formatAsPrice(),
                  style: context.responsiveTextTheme.current.body3Medium.copyWith(),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' ${context.translation!.currency}',
                      style:
                          context.responsiveTextTheme.current.bodyXSmall.copyWith(fontSize: 8, color: Colors.grey[500]),
                    ),
                    TextSpan(
                      text: ' x ${item.quantity}',
                      style: context.responsiveTextTheme.current.bodySmall.copyWith(color: Colors.grey[500]),
                    ),
                    TextSpan(
                      text: ' qty',
                      style:
                          context.responsiveTextTheme.current.bodyXSmall.copyWith(fontSize: 8, color: Colors.grey[500]),
                    ),
                  ],
                )),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text.rich(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        text: "= ",
                        style: context.responsiveTextTheme.current.bodyXSmall.copyWith(color: Colors.grey[500]),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' ${item.totalAmountHt.formatAsPriceForPrint()}',
                            style: context.responsiveTextTheme.current.body2Medium
                                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${context.translation!.currency}',
                            style: context.responsiveTextTheme.current.bodyXSmall
                                .copyWith(fontSize: 8, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
