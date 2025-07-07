import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

import '../../../../config/di/di.dart';

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/urls.dart';

import 'order_item_note.dart';

class OrderItemWidget extends StatelessWidget {
  final String? imageUrl;
  final String productName;
  final int quantity;
  final String price;
  final String? note;

  const OrderItemWidget({
    super.key,
    this.imageUrl,
    required this.productName,
    required this.quantity,
    required this.price,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.3,
        children: <Widget>[
          if (note != null)
            SlidableAction(
              flex: 1,
              onPressed: (BuildContext context) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => OrderNoteDialog(
                    title: 'context.translation!.orderItemNote',
                    note: note!,
                  ),
                );
              },
              // backgroundColor: AppColorsPallette.primaryColors.first.withAlpha(50),
              // foregroundColor: AppColorsPallette.primaryColors.first,
              icon: Icons.notes_rounded,
              label: "context.translation!.note",
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Product Image
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizesManager.p8),
                color: imageUrl == null ? Colors.grey.shade100 : null,
              ),
              child: CachedNetworkImage(
                imageUrl: getItInstance.get<INetworkService>().getFilesPath(
                      '${Urls.publicFiles}$imageUrl',
                    ),
                width: 60,
                height: 60,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.headLine4MediumStyle,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text.rich(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body3MediumStyle.copyWith(color: Colors.grey[500]),
                        TextSpan(
                          text: 'Qty ',
                          children: <InlineSpan>[
                            TextSpan(
                              text: quantity.toString(),
                              style: AppTypography.body3MediumStyle.copyWith(color: TextColors.primary.color),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text.rich(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: double.parse(price).formatAsPrice(),
                          style: AppTypography.body3MediumStyle,
                          children: <InlineSpan>[
                            TextSpan(
                              text: ' dzd',
                              style: AppTypography.bodySmallStyle.copyWith(color: Colors.grey[500]),
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
      ),
    );
  }
}
