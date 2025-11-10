import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/quantity.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnQuantityChanged = void Function(String quantity);

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.end,
      this.disabledPackageQuantity = true,
      required this.decrementQuantity,
      required this.incrementQuantity,
      required this.decrementPackageQuantity,
      required this.incrementPackageQuantity,
      required this.quantityController,
      required this.packageQuantityController,
      required this.onQuantityChanged,
      required this.onPackageQuantityChanged,
      this.displayQuantityLabel = true,
      this.packageSize,
      this.axis = Axis.horizontal});
  final MainAxisAlignment mainAxisAlignment;
  final bool disabledPackageQuantity;
  final VoidCallback decrementQuantity;
  final VoidCallback incrementQuantity;
  final VoidCallback decrementPackageQuantity;
  final VoidCallback incrementPackageQuantity;
  final OnQuantityChanged onQuantityChanged;
  final OnQuantityChanged onPackageQuantityChanged;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;
  final int? packageSize;
  final bool displayQuantityLabel;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return BaseQuantityController(
      axisDirection: axis,
      label: translation.quantity,
      quantityController: quantityController,
      decrement: decrementQuantity,
      increment: incrementQuantity,
      onQuantityChanged: onQuantityChanged,
      mainAxisAlignment: mainAxisAlignment,
      displayQuantityLabel: displayQuantityLabel,
    );
  }
}
