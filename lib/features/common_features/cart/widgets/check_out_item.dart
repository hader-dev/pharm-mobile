import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart' show CacheNetworkImagePlus;
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';

import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

class CheckOutItemWidget extends StatelessWidget {
  final CartItemModel item;

  const CheckOutItemWidget({
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
              border: item.image != null
                  ? null
                  : Border.all(
                      color: const Color.fromARGB(197, 245, 245, 245),
                    ),
            ),
            child: item.image != null
                ? CacheNetworkImagePlus(
                    boxFit: BoxFit.contain,
                    imageUrl: getItInstance.get<INetworkService>().getFilesPath(item.image?.path ?? ''),
                  )
                : Center(
                    child: Image(
                      image: AssetImage(
                        item.medicinesCatalogId != null
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
                  item.designation,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: context.responsiveTextTheme.current.headLine4SemiBold,
                ),
                const ResponsiveGap.s8(),
                Text.rich(TextSpan(
                  text: double.parse(item.unitPriceHt).formatAsPrice(),
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
                            text: ' ${double.parse(item.totalAmountHt).formatAsPriceForPrint()}',
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
