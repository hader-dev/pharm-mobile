import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_icon_button.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class MakeOrderBottomSheet extends StatelessWidget {
  const MakeOrderBottomSheet({super.key, this.cubit});

  final MedicineDetailsCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: cubit ??
              MedicineCatalogDetailsScreen
                  .medicineDetailsScaffoldKey.currentContext!
                  .read<MedicineDetailsCubit>(),
        ),
        BlocProvider.value(
            value: AppLayout.appLayoutScaffoldKey.currentContext!
                .read<OrdersCubit>()),
      ],
      child: BlocListener<MedicineDetailsCubit, MedicineDetailsState>(
        listener: (context, state) {
          if (state is QuickOrderPassed) {
            context.read<OrdersCubit>().getOrders();
            context.pop();
          }
        },
        child: BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(title: translation.make_order),
                Gap(AppSizesManager.s12),
                LabeledInfoWidget(
                  label: translation.product,
                  value: context
                      .read<MedicineDetailsCubit>()
                      .medicineCatalogData!
                      .medicine
                      .dci,
                ),
                LabeledInfoWidget(
                  label: translation.unit_total_price,
                  value:
                      "${(num.parse(context.read<MedicineDetailsCubit>().medicineCatalogData!.unitPriceHt).toStringAsFixed(2))} ${translation.currency}",
                ),
                Gap(AppSizesManager.s12),
                Text(
                  translation.quantity,
                  style: AppTypography.body3MediumStyle.copyWith(
                    color: TextColors.ternary.color,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
                  child: Row(children: [
                    PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: () {
                        context
                            .read<MedicineDetailsCubit>()
                            .decrementQuantity();
                      },
                      icon: Icon(
                        Iconsax.minus,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: AppSizesManager.buttonHeight,
                      width: MediaQuery.sizeOf(context).width * 4 / 6,
                      child: Form(
                          child: TextFormField(
                              cursorColor: AppColors.accentGreenShade1,
                              controller: context
                                  .read<MedicineDetailsCubit>()
                                  .quantityController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) =>
                                  value == null || value.isEmpty ? '' : null,
                              style: AppTypography.body3MediumStyle,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(AppSizesManager.p12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSizesManager.commonWidgetsRadius),
                                  borderSide: BorderSide(
                                      color: FieldState.normal.color.secondary),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSizesManager.commonWidgetsRadius),
                                  borderSide:
                                      BorderSide(color: AppColors.bgDisabled),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSizesManager.commonWidgetsRadius),
                                  borderSide: BorderSide(
                                      color: StrokeColors.focused.color),
                                ),
                              ))),
                    ),
                    Spacer(),
                    PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: () {
                        context
                            .read<MedicineDetailsCubit>()
                            .incrementQuantity();
                      },
                      icon: Icon(
                        Iconsax.add,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                Gap(AppSizesManager.s12),
                InfoWidget(
                    label: context.translation!.shipping_address,
                    bgColor: AppColors.bgWhite,
                    value: CustomTextField(
                      verticalPadding: 0,
                      horizontalPadding: AppSizesManager.p6,
                      initValue: UserManager.instance.currentUser.address,
                      onChanged: (text) => context
                          .read<MedicineDetailsCubit>()
                          .updateShippingAddress(text ?? ''),
                      maxLines: 3,
                      validationFunc: (String? value) {},
                      isFilled: false,
                      isBorderEnabled: true,
                      hintText: context.translation!.shipping_address,
                      hintTextStyle: AppTypography.bodySmallStyle
                          .copyWith(color: Colors.grey),
                    )),
                Gap(AppSizesManager.s12),
                Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                Gap(AppSizesManager.s12),
                InfoWidget(
                  label: translation.total_price,
                  bgColor: AppColors.accentGreenShade3,
                  value: Row(
                    children: [
                      Text(
                        "${(num.parse(context.read<MedicineDetailsCubit>().quantityController.text) * num.parse(context.read<MedicineDetailsCubit>().medicineCatalogData!.unitPriceHt)).toStringAsFixed(2)} translationContext.currency",
                        style: AppTypography.body2MediumStyle
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
                Gap(AppSizesManager.s12),
                Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                Gap(AppSizesManager.s12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizesManager.p4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: PrimaryTextButton(
                          isOutLined: true,
                          label: translation.cancel,
                          spalshColor: AppColors.accent1Shade1.withAlpha(50),
                          labelColor: AppColors.accent1Shade1,
                          onTap: () {
                            context.pop();
                          },
                          borderColor: AppColors.accent1Shade1,
                        ),
                      ),
                      Gap(AppSizesManager.s8),
                      Expanded(
                        flex: 2,
                        child: PrimaryTextButton(
                          label: translation.buy_now,
                          leadingIcon: Iconsax.money4,
                          isLoading: state is PassingQuickOrder,
                          onTap: () {
                            context
                                .read<MedicineDetailsCubit>()
                                .passQuickOrder();
                          },
                          color: AppColors.accent1Shade1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class LabeledInfoWidget extends StatelessWidget {
  final String label;
  final String value;

  const LabeledInfoWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      label: label,
      value: Text(
        value,
        style: AppTypography.body2MediumStyle,
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String label;
  final Widget value;
  final Color bgColor;

  const InfoWidget({
    super.key,
    required this.label,
    required this.value,
    this.bgColor = AppColors.bgDarken,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizesManager.p12),
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(vertical: AppSizesManager.p6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.body3MediumStyle.copyWith(
              color: TextColors.ternary.color,
            ),
          ),
          const Gap(AppSizesManager.s4),
          value
        ],
      ),
    );
  }
}
