import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/info_widget.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CustomQuantity extends StatelessWidget {
  const CustomQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      children: [
        Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
        const ResponsiveGap.s12(),
        InfoWidget(
          label: translation.total_price,
          bgColor: AppColors.accentGreenShade3,
          value: Row(
            children: [
              Text(
                "${(num.parse(context.read<MedicineDetailsCubit>().quantityController.text) * num.parse(context.read<MedicineDetailsCubit>().state.medicineCatalogData!.unitPriceHt)).toStringAsFixed(2)} ${translation.currency}",
                style: context.responsiveTextTheme.current.body2Medium
                    .copyWith(color: AppColors.accent1Shade1),
              ),
              Spacer(),
              Icon(
                Iconsax.wallet_money,
                color: AppColors.accent1Shade1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BaseQuantityController extends StatelessWidget {
  const BaseQuantityController(
      {super.key,
      required this.label,
      required this.decrement,
      required this.increment,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      required this.quantityController});
  final String label;
  final VoidCallback decrement;
  final TextEditingController quantityController;
  final VoidCallback increment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: context.responsiveTextTheme.current.body3Medium.copyWith(
            color: TextColors.ternary.color,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
          child: Row(
            children: [
              PrimaryIconButton(
                borderColor: StrokeColors.normal.color,
                isBordered: true,
                bgColor: Colors.transparent,
                onPressed: decrement,
                icon: Icon(
                  Iconsax.minus,
                  color: Colors.black,
                ),
              ),
              const ResponsiveGap.s12(),
              Flexible(
                child: SizedBox(
                  height: AppSizesManager.buttonHeight,
                  child: Form(
                    child: TextFormField(
                      cursorColor: AppColors.accentGreenShade1,
                      controller: quantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) =>
                          value == null || value.isEmpty ? '' : null,
                      style: context.responsiveTextTheme.current.body3Medium,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(AppSizesManager.p12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizesManager.commonWidgetsRadius),
                          borderSide: BorderSide(
                              color: FieldState.normal.color.secondary),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizesManager.commonWidgetsRadius),
                          borderSide: BorderSide(color: AppColors.bgDisabled),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              AppSizesManager.commonWidgetsRadius),
                          borderSide:
                              BorderSide(color: StrokeColors.focused.color),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const ResponsiveGap.s12(),
              PrimaryIconButton(
                borderColor: StrokeColors.normal.color,
                isBordered: true,
                bgColor: Colors.transparent,
                onPressed: increment,
                icon: Icon(
                  Iconsax.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
