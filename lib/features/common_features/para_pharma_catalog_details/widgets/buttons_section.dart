import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';

import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../models/create_cart_item.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../common/buttons/solid/primary_text_button.dart';

import 'make_order_bottom_sheet.dart' show MakeOrderBottomSheet;
import 'quantity_section.dart' show QuantitySectionModified;

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            QuantitySectionModified(),
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
                              productId: BlocProvider.of<ParaPharmaDetailsCubit>(context).paraPharmaCatalogData!.id,
                              quantity:
                                  int.parse(BlocProvider.of<ParaPharmaDetailsCubit>(context).quantityController.text),
                              productType: ProductTypes.medicine),
                        );
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
                        BottomSheetHelper.showCommonBottomSheet(context: context, child: MakeOrderBottomSheet());
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
