import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/widgets/quantity/quantity.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.end,
  });
  final MainAxisAlignment mainAxisAlignment;
  final disabledPackageQuantity = true;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ParaPharmaDetailsCubit>();
    final translation = context.translation!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          BaseQuantityController(
            label: translation.quantity,
            quantityController: cubit.quantityController,
            decrement: cubit.decrementQuantity,
            increment: cubit.incrementQuantity,
          ),
          if (!disabledPackageQuantity)
            BaseQuantityController(
              label:
                  "${translation.pacakge_quantity} (${cubit.paraPharmaCatalogData?.packageSize})",
              quantityController: cubit.packageQuantityController,
              decrement: cubit.decrementPackageQuantity,
              increment: cubit.incrementPackageQuantity,
            )
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
    //   child: Row(mainAxisAlignment: mainAxisAlignment, children: [
    //     PrimaryIconButton(
    //       borderColor: StrokeColors.normal.color,
    //       isBordered: true,
    //       bgColor: Colors.transparent,
    //       onPressed: () {
    //         cubit.decrementQuantity();
    //       },
    //       icon: Icon(
    //         Iconsax.minus,
    //         color: Colors.black,
    //       ),
    //     ),
    //     SizedBox(
    //       height: AppSizesManager.buttonHeight,
    //       width: 80,
    //       child: TextFormField(
    //           cursorColor: AppColors.accentGreenShade1,
    //           controller: cubit.quantityController,
    //           textAlign: TextAlign.center,
    //           keyboardType: TextInputType.number,
    //           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    //           validator: (value) => value == null || value.isEmpty ? '' : null,
    //           style: context.responsiveTextTheme.current.body1Medium,
    //           decoration: InputDecoration(
    //             enabledBorder: InputBorder.none,
    //             disabledBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(
    //                   AppSizesManager.commonWidgetsRadius),
    //               borderSide: BorderSide(color: AppColors.bgDisabled),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(
    //                   AppSizesManager.commonWidgetsRadius),
    //               borderSide: BorderSide(color: StrokeColors.focused.color),
    //             ),
    //           )),
    //     ),
    //     PrimaryIconButton(
    //       borderColor: StrokeColors.normal.color,
    //       isBordered: true,
    //       bgColor: Colors.transparent,
    //       onPressed: () {
    //         cubit.incrementQuantity();
    //       },
    //       icon: Icon(
    //         Iconsax.add,
    //         color: Colors.black,
    //       ),
    //     ),
    //   ]),
    // );
  }
}
