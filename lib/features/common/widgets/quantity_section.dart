import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/quantity.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.disabledPackageQuantity = false,
    required this.decrementQuantity,
    required this.incrementQuantity,
    required this.decrementPackageQuantity,
    required this.incrementPackageQuantity,
    required this.quantityController,
    required this.packageQuantityController,
    this.packageSize,
  });
  final MainAxisAlignment mainAxisAlignment;
  final bool disabledPackageQuantity;
  final VoidCallback decrementQuantity;
  final VoidCallback incrementQuantity;
  final VoidCallback decrementPackageQuantity;
  final VoidCallback incrementPackageQuantity;
  final TextEditingController quantityController;
  final TextEditingController packageQuantityController;
  final int? packageSize;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          BaseQuantityController(
            label: translation.quantity,
            quantityController: quantityController,
            decrement: decrementQuantity,
            increment: incrementQuantity,
          ),
          if (!disabledPackageQuantity)
            BaseQuantityController(
              label: "${translation.pacakge_quantity} (${packageSize ?? 1})",
              quantityController: packageQuantityController,
              decrement: decrementPackageQuantity,
              increment: incrementPackageQuantity,
            )
        ],
      ),
    );
  }
}
