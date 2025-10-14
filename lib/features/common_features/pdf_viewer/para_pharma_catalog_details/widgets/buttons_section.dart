import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/pdf_viewer/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import 'make_order_bottom_sheet.dart' show MakeOrderBottomSheet;

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    super.key,
    this.onAction,
    this.quantitySectionAlignment = MainAxisAlignment.end,
    this.disabledPackageQuanity = true,
  });

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final bool disabledPackageQuanity;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<ParaPharmaDetailsCubit>();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              QuantitySectionModified(
                  mainAxisAlignment: quantitySectionAlignment,
                  disabledPackageQuantity: disabledPackageQuanity,
                  decrementQuantity: cubit.decrementQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  quantityController: cubit.quantityController,
                  onQuantityChanged: (v) => cubit.updateQuantity(v),
                  onPackageQuantityChanged: (v) => cubit.updateQuantityPackage(v),
                  packageQuantityController: cubit.packageQuantityController),
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
                                  child: MakeOrderBottomSheet(cubit: cubit))
                              .then((res) => onAction?.call());
                        },
                      ),
                    ),
                    const ResponsiveGap.s8(),
                    Expanded(
                      child: PrimaryTextButton(
                        label: translation.add_cart,
                        leadingIcon: Iconsax.add,
                        color: AppColors.accent1Shade1,
                        onTap: () {
                          BlocProvider.of<CartCubit>(context).addToCart(
                              CreateCartItemModel(
                                  productId: cubit.paraPharmaCatalogData!.id,
                                  quantity:
                                      int.parse(cubit.quantityController.text),
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
          ),
        );
      },
    );
  }
}
