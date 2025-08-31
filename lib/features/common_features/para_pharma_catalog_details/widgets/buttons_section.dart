import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'make_order_bottom_sheet.dart' show MakeOrderBottomSheet;
import 'quantity_section.dart' show QuantitySectionModified;

class ButtonsSection extends StatelessWidget {
  const ButtonsSection(
      {super.key,
      this.onAction,
      this.quantitySectionAlignment = MainAxisAlignment.end,
      this.parapharmDetailsCubit});

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final ParaPharmaDetailsCubit? parapharmDetailsCubit;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            QuantitySectionModified(
              mainAxisAlignment: quantitySectionAlignment,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
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
                      onTap: () {
                        BottomSheetHelper.showCommonBottomSheet(
                                context: context,
                                child: MakeOrderBottomSheet(
                                    cubit: parapharmDetailsCubit))
                            .then((res) => onAction?.call());
                      },
                    ),
                  ),
                  Gap(AppSizesManager.s8),
                  Expanded(
                    child: PrimaryTextButton(
                      label: translation.add_cart,
                      leadingIcon: Iconsax.add,
                      color: AppColors.accent1Shade1,
                      onTap: () {
                        BlocProvider.of<CartCubit>(context).addToCart(
                            CreateCartItemModel(
                                productId:
                                    BlocProvider.of<ParaPharmaDetailsCubit>(
                                            context)
                                        .paraPharmaCatalogData!
                                        .id,
                                quantity: int.parse(
                                    BlocProvider.of<ParaPharmaDetailsCubit>(
                                            context)
                                        .quantityController
                                        .text),
                                productType: ProductTypes.para_pharmacy),
                            true);
                        onAction?.call();
                      },
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
