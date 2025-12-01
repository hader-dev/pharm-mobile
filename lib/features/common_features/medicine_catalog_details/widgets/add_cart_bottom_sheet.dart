import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/app_layout/app_layout.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/bottom_sheet_header.dart';
import 'package:hader_pharm_mobile/features/common/widgets/quantity_section.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/cubit/medicine_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/helpers/add_to_cart_or_deligate_items.dart';
import 'package:hader_pharm_mobile/features/common_features/medicine_catalog_details/medicine_catalog_details.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class AddCartBottomSheet extends StatelessWidget {
  const AddCartBottomSheet(
      {super.key,
      this.cubit,
      required this.needCartCubit,
      this.cartCubit,
      this.deligateCreateOrderCubit,
      this.onAction});
  final MedicineDetailsCubit? cubit;
  final CartCubit? cartCubit;
  final VoidCallback? onAction;
  final DeligateCreateOrderCubit? deligateCreateOrderCubit;
  final bool needCartCubit;

  final disabledPackageQuantity = true;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return MultiBlocProvider(
      providers: [
        if (needCartCubit)
          BlocProvider.value(value: cartCubit ?? AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>()),
        if (deligateCreateOrderCubit != null) BlocProvider.value(value: deligateCreateOrderCubit!),
        BlocProvider.value(
          value: cubit ??
              BaseMedicineCatalogDetailsScreen.medicineDetailsScaffoldKey.currentContext!.read<MedicineDetailsCubit>(),
        ),
        BlocProvider.value(value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>()),
      ],
      child: BlocListener<MedicineDetailsCubit, MedicineDetailsState>(
        listener: (context, state) {
          if (state is QuickOrderPassed) {
            AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>().getOrders();
            context.pop();
          }
        },
        child: BlocBuilder<MedicineDetailsCubit, MedicineDetailsState>(
          builder: (context, state) {
            final cubit = context.read<MedicineDetailsCubit>();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(title: translation.add_cart),
                const ResponsiveGap.s12(),
                LabeledInfoWidget(
                  label: translation.product,
                  value: cubit.state.medicineCatalogData.dci,
                ),
                LabeledInfoWidget(
                  label: translation.unit_total_price,
                  value: "${(cubit.state.medicineCatalogData.unitPriceHt.toStringAsFixed(2))} ${translation.currency}",
                ),
                const ResponsiveGap.s12(),
                Row(
                  children: [
                    Flexible(
                        child: InfoWidget(
                            label: translation.min_qty_to_order,
                            value: Text(
                              "${cubit.state.medicineCatalogData.minOrderQuantity}",
                              style: context.responsiveTextTheme.current.body2Medium,
                            ))),
                    ResponsiveGap.s8(),
                    Flexible(
                        child: InfoWidget(
                            label: translation.max_qty_to_order,
                            value: Text(
                              "${cubit.state.medicineCatalogData.maxOrderQuantity}",
                              style: context.responsiveTextTheme.current.body2Medium,
                            ))),
                  ],
                ),
                const ResponsiveGap.s12(),
                QuantitySectionModified(
                  quantityController: cubit.state.quantityController,
                  packageQuantityController: cubit.state.packageQuantityController,
                  packageSize: cubit.state.medicineCatalogData.packageSize,
                  disabledPackageQuantity: true,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementQuantity: cubit.decrementQuantity,
                  onQuantityChanged: cubit.updateQuantity,
                  onPackageQuantityChanged: cubit.updateQuantityPackage,
                  maxQuantity: cubit.state.medicineCatalogData.maxOrderQuantity,
                  minQuantity: cubit.state.medicineCatalogData.minOrderQuantity,
                ),
                const ResponsiveGap.s12(),
                Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                const ResponsiveGap.s12(),
                InfoWidget(
                  label: translation.total_price,
                  bgColor: AppColors.accentGreenShade3,
                  value: Row(
                    children: [
                      Text(
                        "${(num.parse(cubit.state.quantityController.text.isEmpty ? "0" : cubit.state.quantityController.text) * cubit.state.medicineCatalogData.unitPriceHt).toStringAsFixed(2)} ${translation.currency}",
                        style: context.responsiveTextTheme.current.body2Medium.copyWith(color: AppColors.accent1Shade1),
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
                const Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                const ResponsiveGap.s12(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.responsiveAppSizeTheme.current.p4),
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
                          label: translation.add_cart,
                          leadingIcon: Iconsax.money4,
                          isLoading: state is PassingQuickOrder,
                          onTap: (int.parse(
                                          state.quantityController.text.isEmpty ? "0" : state.quantityController.text) <
                                      state.medicineCatalogData.minOrderQuantity ||
                                  state.medicineCatalogData.maxOrderQuantity <
                                      int.parse(
                                          state.quantityController.text.isEmpty ? "0" : state.quantityController.text))
                              ? null
                              : () => addToCartOrDeligateItems(
                                  cubit: cubit,
                                  context: context,
                                  deligateCreateOrderCubit: deligateCreateOrderCubit,
                                  onAction: onAction,
                                  needCartCubit: needCartCubit),
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: context.responsiveAppSizeTheme.current.p6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(context.responsiveAppSizeTheme.current.commonWidgetsRadius),
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
