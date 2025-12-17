import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/decorations/field.dart';
import 'package:hader_pharm_mobile/features/common/decorations/input.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/para_pharma_widget_vertical.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/widgets/custom_price_input.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class OrderProductSelector extends StatelessWidget {
  const OrderProductSelector({super.key});

  FutureOr<List<BaseParaPharmaCatalogModel>> itemsWithSearch(
      String filter, List<BaseParaPharmaCatalogModel> values) async {
    return values
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()) || element.name.toString().contains(filter))
        .toList();
  }

  Widget buildDisplayWidget(BuildContext context, BaseParaPharmaCatalogModel? selectedItem) {
    return Text(
      selectedItem?.name ?? context.translation!.select_product,
      style: context.responsiveTextTheme.current.body3Regular,
    );
  }

  Widget buildProductCard(BuildContext context, BaseParaPharmaCatalogModel product) {
    final cubit = context.read<DelegateCreateOrderCubit>();
    final translation = context.translation!;

    return Container(
      margin: EdgeInsets.only(top: context.responsiveAppSizeTheme.current.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ParaPharmaWidgetVertical(
            paraPharmData: product,
            displayTags: false,
            showQuickAddButton: false,
          ),
          SizedBox(height: context.responsiveAppSizeTheme.current.s12),
          QuantitySectionModified(
              quantityController: cubit.state.quantityController,
              packageQuantityController: cubit.state.packageQuantityController,
              disabledPackageQuantity: false,
              packageSize: product.packageSize,
              decrementPackageQuantity: cubit.decrementPackageQuantity,
              incrementPackageQuantity: cubit.incrementPackageQuantity,
              incrementQuantity: cubit.incrementQuantity,
              decrementQuantity: cubit.decrementQuantity,
              onQuantityChanged: cubit.updateQuantity,
              onPackageQuantityChanged: cubit.updateQuantityPackage),
          const ResponsiveGap.s12(),
          CustomPriceFormField(
            enabled: false,
            customPriceController: cubit.state.customPriceController,
            translation: translation,
            onPriceChanged: cubit.updateCustomPrice,
          ),
          const ResponsiveGap.s8(),
          InfoWidget(
            label: context.translation!.total_amount,
            bgColor: AppColors.accentGreenShade3,
            value: Row(
              children: [
                Text(
                  "${cubit.state.totalPrice.toStringAsFixed(2)} ${context.translation!.currency}",
                  style: context.responsiveTextTheme.current.body2Medium.copyWith(color: AppColors.accent1Shade1),
                ),
                const Spacer(),
                Icon(
                  Iconsax.wallet_money,
                  color: AppColors.accent1Shade1,
                ),
              ],
            ),
          ),
          const ResponsiveGap.s8(),
          PrimaryTextButton(
            onTap: cubit.addOrderItem,
            label: context.translation!.add_cart,
            labelColor: Colors.white,
            color: AppColors.accent1Shade1,
          )
        ],
      ),
    );
  }

  bool compareFn(BaseParaPharmaCatalogModel a, BaseParaPharmaCatalogModel b) => a.id == b.id;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return BlocBuilder<DelegateCreateOrderCubit, DelegateCreateOrderState>(
      builder: (context, state) {
        final products = state.products;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownSearch<BaseParaPharmaCatalogModel>(
                selectedItem: state.selectedProduct,
                items: (query, props) async => itemsWithSearch(query, products),
                compareFn: compareFn,
                popupProps: PopupProps.modalBottomSheet(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration:
                        buildInputDecorationCustomFieldStyle(translation.select_product, FieldState.normal, context),
                  ),
                ),
                itemAsString: (item) => item.name,
                dropdownBuilder: buildDisplayWidget,
                onChanged: (selectedProduct) {
                  if (selectedProduct != null) {
                    context.read<DelegateCreateOrderCubit>().selectProduct(selectedProduct);
                  }
                },
                decoratorProps: DropDownDecoratorProps(
                  decoration: buildDropdownInputDecoration(context.translation!.select_product, context),
                ),
              ),
              if (state.selectedProduct != null) buildProductCard(context, state.selectedProduct!),
            ],
          ),
        );
      },
    );
  }
}
