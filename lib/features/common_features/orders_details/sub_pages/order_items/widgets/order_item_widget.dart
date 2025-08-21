import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/routes/routing_manager.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/accordions/ink_accordion.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/sub_pages/order_items/widgets/order_item_content.dart';
import 'package:hader_pharm_mobile/features/common_features/orders_details/widgets/order_item_note.dart';
import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;

  const OrderItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.3,
            children: <Widget>[
              if (item.note != null)
                SlidableAction(
                  flex: 1,
                  onPressed: (BuildContext context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => OrderNoteDialog(
                        title: context.translation!.note,
                        note: item.note ?? "",
                      ),
                    );
                  },
                  icon: Icons.notes_rounded,
                  label: context.translation!.note,
                ),
            ],
          ),
          child: InkAccordion(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizesManager.p8),
                          color: item.imageUrl == null
                              ? Colors.grey.shade100
                              : null,
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              getItInstance.get<INetworkService>().getFilesPath(
                                    '${Urls.publicFiles}${item.imageUrl}',
                                  ),
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: AppSizesManager.s8),
                      Text(
                        item.designation ?? context.translation!.unknown,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style:
                            context.responsiveTextTheme.current.headLine4Medium,
                      ),
                    ],
                  ),
                  const Gap(AppSizesManager.s8),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: ItemContent(
                      itemId: item.id,
                      quantity: item.quantity,
                      price: item.unitPriceHt.toString(),
                      orderId: item.orderId,
                    ),
                  )
                ],
              ),
              children: [
                PrimaryTextButton(
                  label: context.translation!.item_complaint,
                  onTap: () => RoutingManager.router.pushNamed(
                      RoutingManager.orderComplaint,
                      extra: {"orderId": item.orderId, "itemId": item.id}),
                  color: AppColors.accent1Shade1,
                )
              ]),
        );
      },
    );
  }
}
