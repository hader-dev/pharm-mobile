import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'make_order_bottom_sheet.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection(
      {super.key,
      this.medicineDetailsCubit,
      this.onAction,
      this.price,
      required this.minOrderQuantity,
      required this.maxOrderQuantity,
      this.quantitySectionAlignment = MainAxisAlignment.center,
      this.disabledPackageQuanity = false});

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final MedicineDetailsCubit? medicineDetailsCubit;
  final bool disabledPackageQuanity;
  final double? price;
  final int minOrderQuantity;
  final int maxOrderQuantity;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<MedicineDetailsCubit>();

    return BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
      builder: (context, state) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: InfoWidget(
                            label: "Min qty to order",
                            value: Text(
                              "${cubit.state.medicineCatalogData.minOrderQuantity}",
                              style: context.responsiveTextTheme.current.body2Medium,
                            ))),
                    ResponsiveGap.s8(),
                    Flexible(
                        child: InfoWidget(
                            label: "Max qty to order",
                            value: Text(
                              "${cubit.state.medicineCatalogData.maxOrderQuantity}",
                              style: context.responsiveTextTheme.current.body2Medium,
                            ))),
                  ],
                ),
                QuantitySectionModified(
                  minQuantity: minOrderQuantity,
                  maxQuantity: maxOrderQuantity,
                  packageSize: medicineDetailsCubit?.state.medicineCatalogData.packageSize,
                  mainAxisAlignment: quantitySectionAlignment,
                  disabledPackageQuantity: disabledPackageQuanity,
                  decrementQuantity: cubit.decrementQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  quantityController: cubit.state.quantityController,
                  packageQuantityController: cubit.state.packageQuantityController,
                  onQuantityChanged: (v) => cubit.updateQuantity(v),
                  onPackageQuantityChanged: (v) => cubit.updateQuantityPackage(v),
                ),
                if (price != null)
                  InfoWidget(
                    label: translation.total_price,
                    bgColor: AppColors.accentGreenShade3,
                    value: Row(
                      children: [
                        Text(
                          "${(price! * int.parse(cubit.state.quantityController.text)).toStringAsFixed(2)} ${translation.currency}",
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent1Shade1,
                          ),
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
                          textOverflow: TextOverflow.ellipsis,
                          label: translation.buy_now,
                          maxWidth: MediaQuery.of(context).size.width * 0.25,
                          leadingIcon: Iconsax.money4,
                          spalshColor: AppColors.accent1Shade1.withAlpha(50),
                          labelColor: AppColors.accent1Shade1,
                          borderColor: AppColors.accent1Shade1,
                          onTap: int.parse(cubit.state.quantityController.text) <= maxOrderQuantity &&
                                  int.parse(cubit.state.quantityController.text) >= minOrderQuantity
                              ? () {
                                  BottomSheetHelper.showCommonBottomSheet(
                                      context: context,
                                      child: MakeOrderBottomSheet(
                                        cubit: medicineDetailsCubit,
                                      )).then((res) => onAction?.call());
                                }
                              : null,
                        ),
                      ),
                      const ResponsiveGap.s8(),
                      Expanded(
                        child: PrimaryTextButton(
                          textOverflow: TextOverflow.ellipsis,
                          label: translation.add_cart,
                          leadingIcon: Iconsax.add,
                          color: AppColors.accent1Shade1,
                          onTap: int.parse(cubit.state.quantityController.text) <= maxOrderQuantity &&
                                  int.parse(cubit.state.quantityController.text) >= minOrderQuantity
                              ? () {
                                  BlocProvider.of<CartCubit>(context).addToCart(
                                    CreateCartItemModel(
                                        productId:
                                            BlocProvider.of<MedicineDetailsCubit>(context).state.medicineCatalogData.id,
                                        quantity: int.parse(BlocProvider.of<MedicineDetailsCubit>(context)
                                            .state
                                            .quantityController
                                            .text),
                                        productType: ProductTypes.medicine),
                                  );
                                  onAction?.call();
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
