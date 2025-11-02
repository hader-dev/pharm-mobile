import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/quantity.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

typedef OnQuantityChanged = void Function(String quantity);

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified({
    super.key,
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
    this.packageSize,
  });
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

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.responsiveAppSizeTheme.current.p8),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          BaseQuantityController(
            label: translation.quantity,
            quantityController: quantityController,
            decrement: decrementQuantity,
            increment: incrementQuantity,
            onQuantityChanged: onQuantityChanged,
          ),
          // if (!disabledPackageQuantity)
          //   BaseQuantityController(
          //     label: "${translation.pacakge_quantity} (${packageSize ?? 1})",
          //     quantityController: packageQuantityController,
          //     decrement: decrementPackageQuantity,
          //     increment: incrementPackageQuantity,
          //     onQuantityChanged: onPackageQuantityChanged,
          //   ),
          if (packageSize != null)
            Text(
              "${translation.total_items_in_packages_quantity}: ${packageQuantityController.text},",
              style: context.responsiveTextTheme.current.body3Medium.copyWith(
                color: TextColors.ternary.color,
              ),
            ),
        ],
      ),
    );
  }
}
