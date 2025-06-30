import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';

import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../config/theme/typoghrapy_manager.dart';
import '../../../../utils/constants.dart';

import '../../../common/buttons/solid/primary_icon_button.dart';

class QuantitySectionModified extends StatelessWidget {
  const QuantitySectionModified({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicineDetailsCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
      child: Row(children: [
        Spacer(),
        PrimaryIconButton(
          borderColor: StrokeColors.normal.color,
          isBordered: true,
          bgColor: Colors.transparent,
          onPressed: () {
            cubit.decrementQuantity();
          },
          icon: Icon(
            Iconsax.minus,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: AppSizesManager.buttonHeight,
          width: 80,
          child: Form(
              // key: formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                  cursorColor: AppColors.accentGreenShade1,
                  controller: cubit.quantityController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => value == null || value.isEmpty ? '' : null,
                  style: AppTypography.body1MediumStyle,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                      borderSide: BorderSide(color: AppColors.bgDisabled),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                      borderSide: BorderSide(color: StrokeColors.focused.color),
                    ),
                  ))),
        ),
        PrimaryIconButton(
          borderColor: StrokeColors.normal.color,
          isBordered: true,
          bgColor: Colors.transparent,
          onPressed: () {
            cubit.incrementQuantity();
          },
          icon: Icon(
            Iconsax.add,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
