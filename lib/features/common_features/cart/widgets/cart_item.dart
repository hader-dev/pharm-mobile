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
  final CartItemModel cartItemData;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController packageQuantityController =
      TextEditingController();
  CartItemWidget({super.key, required this.cartItemData});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    quantityController.text = cartItemData.quantity.toString();
    packageQuantityController.text = cartItemData.packageQuantity.toString();

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
                      cartItemData.designation,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          context.responsiveTextTheme.current.headLine5SemiBold,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        cartCubit.deleteCartItem(cartItemData.id);
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
                      dataValue: num.parse(cartItemData.unitPriceHt)
                          .toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: context.translation!.unit_ttc_price,
                      dataValue: num.parse(cartItemData.unitPriceTtc)
                          .toStringAsFixed(2),
                    ),
                    InfoRow(
                      label: "${context.translation!.tva}%",
                      dataValue: num.parse(cartItemData.tvaPercentage)
                          .toStringAsFixed(2),
                    ),
                    QuantitySectionModified(
                      disabledPackageQuantity: false,
                      decrementQuantity: () =>
                          cartCubit.decreaseCartItemQuantity(cartItemData.id),
                      incrementQuantity: () =>
                          cartCubit.increaseCartItemQuantity(cartItemData.id),
                      decrementPackageQuantity: () => cartCubit
                          .decreaseCartItemPackageQuantity(cartItemData.id),
                      incrementPackageQuantity: () => cartCubit
                          .increaseCartItemPackageQuantity(cartItemData.id),
                      quantityController: quantityController,
                      packageQuantityController: packageQuantityController,
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
