import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/create_company_profile/sub_pages/review_and_sumbit/widgets/info_row.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModelUi item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

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
      child: Row(
        children: [
          const ResponsiveGap.s12(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.model.designation,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          context.responsiveTextTheme.current.headLine5SemiBold,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        cartCubit.deleteCartItem(item);
                      },
                      child: const Icon(
                        Iconsax.trash,
                        color: Colors.red,
                        size: AppSizesManager.iconSize20,
                      ),
                    )
                  ],
                ),
                const ResponsiveGap.s12(),
                Column(
                  children: [
                    InfoRow(
                      label: context.translation!.unit_ht_price,
                      dataValue:
                          num.parse(item.model.unitPriceHt).toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: context.translation!.unit_ttc_price,
                      dataValue:
                          num.parse(item.model.unitPriceTtc).toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: "${context.translation!.tva}%",
                      dataValue: num.parse(item.model.tvaPercentage)
                          .toStringAsFixed(2),
                    ),
                    QuantitySectionModified(
                      disabledPackageQuantity: true,
                      packageSize: item.model.packageSize,
                      decrementQuantity: () =>
                          cartCubit.decreaseCartItemQuantity(item),
                      incrementQuantity: () =>
                          cartCubit.increaseCartItemQuantity(item),
                      decrementPackageQuantity: () =>
                          cartCubit.decreaseCartItemPackageQuantity(item),
                      incrementPackageQuantity: () =>
                          cartCubit.increaseCartItemPackageQuantity(item),
                      quantityController: item.quantityController,
                      onQuantityChanged: (value) =>
                          cartCubit.updateItemQuantity(item),
                      onPackageQuantityChanged: (value) =>
                          cartCubit.updateItemPackageQuantity(item),
                      packageQuantityController: item.packageQuantityController,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
