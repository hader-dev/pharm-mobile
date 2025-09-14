import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/quantity.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });

  final MainAxisAlignment mainAxisAlignment;
  final bool disabledPackageQuantity = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineDetailsCubit>();
    final translation = context.translation!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Column(mainAxisAlignment: mainAxisAlignment, children: [
        BaseQuantityController(
          label: translation.quantity,
          quantityController: cubit.quantityController,
          decrement: cubit.decrementQuantity,
          increment: cubit.incrementQuantity,
        ),
        if (!disabledPackageQuantity)
          BaseQuantityController(
            label:
                "${translation.pacakge_quantity} (${cubit.state.medicineCatalogData?.packageSize})",
            quantityController: cubit.packageQuantityController,
            decrement: cubit.decrementPackageQuantity,
            increment: cubit.incrementPackageQuantity,
          )
      ]),
    );
  }
}
