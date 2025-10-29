import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

void addToCartOrDeligateItems({
  required MedicineDetailsCubit cubit,
  required BuildContext context,
  DeligateCreateOrderCubit? deligateCreateOrderCubit,
  required bool needCartCubit,
  VoidCallback? onAction,
}) {
  if (needCartCubit) {
    BlocProvider.of<CartCubit>(context)
        .addToCart(
            CreateCartItemModel(
                productId: cubit.state.medicineCatalogData.id,
                quantity: int.parse(cubit.state.quantityController.text),
                productType: ProductTypes.medicine),
            true)
        .then((res) {
      if (res) {
        onAction?.call();
      }
    });
  } else {
    // deligateCreateOrderCubit?.addProvidedOrderItem(
    //   DeligateParahparmOrderItemUi(
    //     quantityController:
    //         TextEditingController(text: cubit.state.quantityController.text),
    //     customPriceController: TextEditingController(
    //         text: cubit.state.medicineCatalogData.unitPriceHt.toString()),
    //     packageQuantityController: TextEditingController(
    //         text: cubit.state.packageQuantityController.text),
    //     model: DeligateParahparmOrderItem(
    //       isParapharm: true,
    //       product: cubit.state.medicineCatalogData,
    //       quantity: int.parse(
    //         cubit.state.quantityController.text,
    //       ),
    //       suggestedPrice: double.parse(
    //           cubit.state.medicineCatalogData.unitPriceHt.toString()),
    //     ),
    //   ),
    // );
  }
}
