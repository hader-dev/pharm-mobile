import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/custom_price_input.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/quantity_widget.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateOrderItemWidget extends StatefulWidget {
  DeligateOrderItemWidget({super.key, required this.item});
  final DeligateOrderItem item;
  final quantityController = TextEditingController();
  final customPriceController = TextEditingController();

  @override
  State<DeligateOrderItemWidget> createState() =>
      _DeligateOrderItemWidgetState();
}

class _DeligateOrderItemWidgetState extends State<DeligateOrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = BlocProvider.of<DeligateCreateOrderCubit>(context);
    final unitPrice = (widget.item.suggestedPrice ??
        double.parse(widget.item.product.unitPriceHt));
    final totalPrice = unitPrice * widget.item.quantity;
    widget.quantityController.text = widget.item.quantity.toString();
    widget.customPriceController.text = unitPrice.toString();

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p8, horizontal: AppSizesManager.p4),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p10, horizontal: AppSizesManager.p10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CacheNetworkImagePlus(
                height: 70,
                width: 70,
                boxFit: BoxFit.fill,
                imageUrl: widget.item.product.image?.path != null
                    ? getItInstance
                        .get<INetworkService>()
                        .getFilesPath(widget.item.product.image!.path)
                    : "",
                errorWidget: Column(
                  children: [
                    Spacer(),
                    Icon(Iconsax.image,
                        color: Color.fromARGB(255, 197, 197, 197),
                        size: AppSizesManager.iconSize30),
                    const ResponsiveGap.s8(),
                    Text(
                      context.translation!.image_not_available,
                      style: context.responsiveTextTheme.current.body3Medium
                          .copyWith(
                              color: const Color.fromARGB(255, 197, 197, 197)),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const ResponsiveGap.s12(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.item.product.name,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: context
                              .responsiveTextTheme.current.headLine5SemiBold,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            cubit.removeOrderItem(widget.item);
                          },
                          child: const Icon(
                            Iconsax.trash,
                            color: Colors.red,
                            size: AppSizesManager.iconSize20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.accent1Shade1,
          ),
          DeligateOrderItemQuantity(
              translation: translation,
              quantityController: widget.quantityController,
              onDecrement: () => cubit.decrementItemQuantity(widget.item,
                  widget.quantityController, widget.customPriceController),
              onIncrement: () => cubit.incrementItemQuantity(widget.item,
                  widget.quantityController, widget.customPriceController)),
          const SizedBox(height: AppSizesManager.s12),
          CustomPriceFormField(
            customPriceController: widget.customPriceController,
            translation: translation,
            onPriceChanged: (value) =>
                cubit.updateItemCustomPrice(value, widget.item),
          ),
          const Divider(
            color: AppColors.accent1Shade1,
          ),
          InfoRow(
              label: context.translation!.quantity,
              dataValue: widget.item.quantity.toString()),
          InfoRow(
              label: context.translation!.price,
              dataValue: unitPrice.toString()),
          InfoRow(
              label: context.translation!.total_price,
              dataValue: totalPrice.toString()),
        ],
      ),
    );
  }
}
