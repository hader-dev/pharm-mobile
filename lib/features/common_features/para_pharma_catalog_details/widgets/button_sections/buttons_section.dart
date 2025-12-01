import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../make_order_bottom_sheet.dart' show MakeOrderBottomSheet, InfoWidget;

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    super.key,
    this.onAction,
    this.quantitySectionAlignment = MainAxisAlignment.end,
    this.disabledPackageQuanity = true,
    this.minOrderQuantity = 1,
    this.maxOrderQuantity = 9999,
    this.price,
  });

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final bool disabledPackageQuanity;
  final double? price;
  final int minOrderQuantity;
  final int maxOrderQuantity;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<ParaPharmaDetailsCubit>();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: InfoWidget(
                          label: translation.min_qty_to_order,
                          value: Text(
                            "${cubit.state.paraPharmaCatalogData.minOrderQuantity}",
                            style: context.responsiveTextTheme.current.body2Medium,
                          ))),
                  ResponsiveGap.s8(),
                  Flexible(
                      child: InfoWidget(
                          label: translation.max_qty_to_order,
                          value: Text(
                            "${cubit.state.paraPharmaCatalogData.maxOrderQuantity}",
                            style: context.responsiveTextTheme.current.body2Medium,
                          ))),
                ],
              ),
              QuantitySectionModified(
                  minQuantity: minOrderQuantity,
                  maxQuantity: maxOrderQuantity,
                  packageSize: cubit.state.paraPharmaCatalogData.packageSize,
                  mainAxisAlignment: quantitySectionAlignment,
                  disabledPackageQuantity: disabledPackageQuanity,
                  decrementQuantity: cubit.decrementQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  quantityController: cubit.state.quantityController,
                  onQuantityChanged: (v) => cubit.updateQuantity(v),
                  onPackageQuantityChanged: (v) => cubit.updateQuantityPackage(v),
                  packageQuantityController: cubit.state.packageQuantityController),
              if (price != null)
                InfoWidget(
                  label: translation.total_price,
                  bgColor: AppColors.accentGreenShade3,
                  value: Row(
                    children: [
                      Text(
                        "${(num.parse(cubit.state.quantityController.text.isEmpty ? "0" : cubit.state.quantityController.text) * cubit.state.paraPharmaCatalogData.unitPriceHt).toStringAsFixed(2)} ${translation.currency}",
                        style: context.responsiveTextTheme.current.body2Medium.copyWith(color: AppColors.accent1Shade1),
                      ),
                      const Spacer(),
                      const Icon(
                        Iconsax.wallet_money,
                        color: AppColors.accent1Shade1,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryTextButton(
                        isOutLined: true,
                        label: translation.buy_now,
                        spalshColor: AppColors.accent1Shade1.withAlpha(50),
                        labelColor: AppColors.accent1Shade1,
                        borderColor: AppColors.accent1Shade1,
                        maxWidth: MediaQuery.of(context).size.width * 0.25,
                        leadingIcon: Iconsax.money4,
                        onTap: int.parse(cubit.state.quantityController.text.isEmpty
                                        ? "0"
                                        : cubit.state.quantityController.text) <=
                                    maxOrderQuantity &&
                                int.parse(cubit.state.quantityController.text.isEmpty
                                        ? "0"
                                        : cubit.state.quantityController.text) >=
                                    minOrderQuantity
                            ? () {
                                BottomSheetHelper.showCommonBottomSheet(
                                        context: context, child: MakeOrderBottomSheet(cubit: cubit))
                                    .then((res) => onAction?.call());
                              }
                            : null,
                      ),
                    ),
                    const ResponsiveGap.s8(),
                    Expanded(
                      child: PrimaryTextButton(
                        label: translation.add_cart,
                        leadingIcon: Iconsax.add,
                        color: AppColors.accent1Shade1,
                        onTap: int.parse(cubit.state.quantityController.text.isEmpty
                                        ? "0"
                                        : cubit.state.quantityController.text) <=
                                    maxOrderQuantity &&
                                int.parse(cubit.state.quantityController.text.isEmpty
                                        ? "0"
                                        : cubit.state.quantityController.text) >=
                                    minOrderQuantity
                            ? () {
                                BlocProvider.of<CartCubit>(context).addToCart(
                                    CreateCartItemModel(
                                        productId: cubit.state.paraPharmaCatalogData.id,
                                        quantity: int.parse(cubit.state.quantityController.text.isEmpty
                                            ? "0"
                                            : cubit.state.quantityController.text),
                                        productType: ProductTypes.para_pharmacy),
                                    true);
                                onAction?.call();
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
