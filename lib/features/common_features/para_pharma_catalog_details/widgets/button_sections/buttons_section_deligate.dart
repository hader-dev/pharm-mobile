import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_marketplace/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

import '../make_order_bottom_sheet.dart' show InfoWidget;

class ButtonsSectionDeligate extends StatelessWidget {
  const ButtonsSectionDeligate({
    super.key,
    this.onAction,
    this.quantitySectionAlignment = MainAxisAlignment.end,
    this.disabledPackageQuanity = true,
    this.price,
  });

  final VoidCallback? onAction;
  final MainAxisAlignment quantitySectionAlignment;
  final bool disabledPackageQuanity;
  final double? price;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    final cubit = context.read<ParaPharmaDetailsCubit>();

    return BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              QuantitySectionModified(
                  packageSize: cubit.state.paraPharmaCatalogData.packageSize,
                  mainAxisAlignment: quantitySectionAlignment,
                  disabledPackageQuantity: disabledPackageQuanity,
                  decrementQuantity: cubit.decrementQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  quantityController: cubit.state.quantityController,
                  onQuantityChanged: (v) => cubit.updateQuantity(v),
                  onPackageQuantityChanged: (v) =>
                      cubit.updateQuantityPackage(v),
                  packageQuantityController:
                      cubit.state.packageQuantityController),
              if (price != null)
                InfoWidget(
                  label: translation.total_price,
                  bgColor: AppColors.accentGreenShade3,
                  value: Row(
                    children: [
                      Text(
                        "${(num.parse(cubit.state.quantityController.text) * cubit.state.paraPharmaCatalogData.unitPriceHt).toStringAsFixed(2)} ${translation.currency}",
                        style: context.responsiveTextTheme.current.body2Medium
                            .copyWith(color: AppColors.accent1Shade1),
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
                padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                child: PrimaryTextButton(
                  label: translation.add_cart,
                  leadingIcon: Iconsax.add,
                  color: AppColors.accent1Shade1,
                  onTap: () {
                    final deligateCubit = DeligateMarketPlaceScreen
                        .marketPlaceScaffoldKey.currentContext!
                        .read<DeligateCreateOrderCubit>();

                    deligateCubit.addProvidedOrderItem(
                      DeligateParahparmOrderItemUi(
                        quantityController: TextEditingController(
                            text: cubit.state.quantityController.text),
                        customPriceController: TextEditingController(
                            text: cubit.state.paraPharmaCatalogData.unitPriceHt
                                .toString()),
                        packageQuantityController: TextEditingController(
                            text: cubit.state.packageQuantityController.text),
                        model: DeligateParahparmOrderItem(
                          isParapharm: true,
                          product: cubit.state.paraPharmaCatalogData,
                          quantity: int.parse(
                            cubit.state.quantityController.text,
                          ),
                          suggestedPrice: double.parse(cubit
                              .state.paraPharmaCatalogData.unitPriceHt
                              .toString()),
                        ),
                      ),
                    );
                    onAction?.call();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
