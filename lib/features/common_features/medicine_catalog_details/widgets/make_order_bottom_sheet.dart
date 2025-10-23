import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class MakeOrderBottomSheet extends StatelessWidget {
  const MakeOrderBottomSheet({super.key, this.cubit});

  final MedicineDetailsCubit? cubit;
  final bool disabledPackageQuantity = true;
  @override
  StatelessWidget build(BuildContext context) {
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
      child: BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
        builder: (context, state) {
          final cubit = context.read<MedicineDetailsCubit>();

          if (state is QuickOrderPassed) {
            AppLayout.appLayoutScaffoldKey.currentContext!
                .read<OrdersCubit>()
                .getOrders();
            context.pop();
          }

          return Form(
            key: cubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(title: translation.make_order),
                const ResponsiveGap.s12(),
                LabeledInfoWidget(
                  label: translation.product,
                  value: context
                      .read<MedicineDetailsCubit>()
                      .state
                      .medicineCatalogData!
                      .medicine
                      .dci,
                ),
                LabeledInfoWidget(
                  label: translation.unit_total_price,
                  value:
                      "${(num.parse(context.read<MedicineDetailsCubit>().state.medicineCatalogData!.unitPriceHt).toStringAsFixed(2))} ${translation.currency}",
                ),
                const ResponsiveGap.s12(),
                QuantitySectionModified(
                  quantityController: cubit.quantityController,
                  packageQuantityController: cubit.packageQuantityController,
                  packageSize: cubit.state.medicineCatalogData?.packageSize,
                  disabledPackageQuantity: true,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementQuantity: cubit.decrementQuantity,
                  onQuantityChanged: cubit.updateQuantity,
                  onPackageQuantityChanged: cubit.updateQuantityPackage,
                ),
                const ResponsiveGap.s12(),
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
                      validationFunc: (v) => requiredValidator(v, translation),
                      isFilled: false,
                      isBorderEnabled: true,
                      hintText: context.translation!.shipping_address,
                      hintTextStyle: context
                          .responsiveTextTheme.current.bodySmall
                          .copyWith(color: Colors.grey),
                    )),
                const ResponsiveGap.s12(),
                const Divider(
                    color: AppColors.bgDisabled, thickness: 1, height: 1),
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
                      const Spacer(),
                      const Icon(
                        Iconsax.wallet_money,
                        color: AppColors.accent1Shade1,
                      ),
                    ],
                  ),
                ),
                const ResponsiveGap.s12(),
                const Divider(
                    color: AppColors.bgDisabled, thickness: 1, height: 1),
                const ResponsiveGap.s12(),
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
                      const ResponsiveGap.s8(),
                      Expanded(
                        flex: 2,
                        child: PrimaryTextButton(
                          label: translation.buy_now,
                          leadingIcon: Iconsax.money4,
                          isLoading: state is PassingQuickOrder,
                          onTap: () {
                            context
                                .read<MedicineDetailsCubit>()
                                .passQuickOrder()
                                .then((sucess) =>
                                    getItInstance.get<ToastManager>().showToast(
                                          message: sucess
                                              ? translation
                                                  .order_placed_successfully
                                              : translation.order_placed_failed,
                                          type: sucess
                                              ? ToastType.success
                                              : ToastType.error,
                                        ));
                          },
                          color: AppColors.accent1Shade1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
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
  StatelessWidget build(BuildContext context) {
    return InfoWidget(
      label: label,
      value: Text(
        value,
        style: context.responsiveTextTheme.current.body2Medium,
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
  StatelessWidget build(BuildContext context) {
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
            style: context.responsiveTextTheme.current.body3Medium.copyWith(
              color: TextColors.ternary.color,
            ),
          ),
          const ResponsiveGap.s4(),
          value
        ],
      ),
    );
  }
}
