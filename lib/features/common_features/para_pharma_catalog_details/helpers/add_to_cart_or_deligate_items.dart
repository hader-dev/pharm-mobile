import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/models/deligate_order.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

void addToCartOrDeligateItems({
  required ParaPharmaDetailsCubit cubit,
  required BuildContext context,
  DelegateCreateOrderCubit? deligateCreateOrderCubit,
  required bool needCartCubit,
  VoidCallback? onAction,
}) {
  if (needCartCubit) {
    BlocProvider.of<CartCubit>(context)
        .addToCart(
            CreateCartItemModel(
                productId: cubit.state.paraPharmaCatalogData.id,
                quantity: int.parse(cubit.state.quantityController.text),
                productType: ProductTypes.para_pharmacy),
            true)
        .then((res) {
      if (res) {
        onAction?.call();
      }
    });
  } else {
    deligateCreateOrderCubit?.addProvidedOrderItem(
      DeligateParahparmOrderItemUi(
        quantityController: TextEditingController(text: cubit.state.quantityController.text),
        customPriceController: TextEditingController(text: cubit.state.paraPharmaCatalogData.unitPriceHt.toString()),
        packageQuantityController: TextEditingController(text: cubit.state.packageQuantityController.text),
        model: DeligateParahparmOrderItem(
          isParapharm: true,
          product: cubit.state.paraPharmaCatalogData,
          quantity: int.parse(
            cubit.state.quantityController.text,
          ),
          suggestedPrice: double.parse(cubit.state.paraPharmaCatalogData.unitPriceHt.toString()),
        ),
      ),
    );
  }
}
