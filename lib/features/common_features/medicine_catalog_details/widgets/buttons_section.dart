import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:iconsax/iconsax.dart';
import 'make_order_bottom_sheet.dart';
import 'quantity_section.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key, this.onAction,  this.quantitySectionAlignment = MainAxisAlignment.center});

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            QuantitySectionModified(mainAxisAlignment: quantitySectionAlignment,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextButton(
                      isOutLined: true,
                      label: "Add to cart",
                      leadingIcon: Iconsax.add,
                      labelColor: AppColors.accent1Shade1,
                      onTap: () {
                        BlocProvider.of<CartCubit>(context).addToCart(
                          CreateCartItemModel(
                              productId:
                                  BlocProvider.of<MedicineDetailsCubit>(context)
                                      .medicineCatalogData!
                                      .id,
                              quantity: int.parse(
                                  BlocProvider.of<MedicineDetailsCubit>(context)
                                      .quantityController
                                      .text),
                              productType: ProductTypes.medicine),
                        );
                        onAction?.call();
                      },
                      borderColor: AppColors.accent1Shade1,
                    ),
                  ),
                  Gap(AppSizesManager.s8),
                  Expanded(
                    child: PrimaryTextButton(
                      label: "Buy now",
                      leadingIcon: Iconsax.money4,
                      onTap: () {
                        BottomSheetHelper.showCommonBottomSheet(
                            context: context, child: MakeOrderBottomSheet());
                        onAction?.call();
                      },
                      color: AppColors.accent1Shade1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
