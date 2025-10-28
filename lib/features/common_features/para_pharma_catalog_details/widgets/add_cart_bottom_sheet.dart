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
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/cubit/para_pharma_details_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/para_pharma_catalog_details.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

class AddCartBottomSheet extends StatelessWidget {
  const AddCartBottomSheet(
      {super.key, this.cubit, this.cartCubit, this.onAction});
  final ParaPharmaDetailsCubit? cubit;
  final CartCubit? cartCubit;
  final VoidCallback? onAction;

  final disabledPackageQuantity = true;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: cartCubit ??
                AppLayout.appLayoutScaffoldKey.currentContext!
                    .read<CartCubit>()),
        BlocProvider.value(
          value: cubit ??
              BaseParaPharmaCatalogDetailsScreen
                  .paraPharmaDetailsScaffoldKey.currentContext!
                  .read<ParaPharmaDetailsCubit>(),
        ),
        BlocProvider.value(
            value: AppLayout.appLayoutScaffoldKey.currentContext!
                .read<OrdersCubit>()),
      ],
      child: BlocListener<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
        listener: (context, state) {
          if (state is QuickOrderPassed) {
            AppLayout.appLayoutScaffoldKey.currentContext!
                .read<OrdersCubit>()
                .getOrders();
            context.pop();
          }
        },
        child: BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
          builder: (context, state) {
            final cubit = context.read<ParaPharmaDetailsCubit>();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(title: translation.add_cart),
                const ResponsiveGap.s12(),
                LabeledInfoWidget(
                  label: translation.product,
                  value: cubit.state.paraPharmaCatalogData.name,
                ),
                LabeledInfoWidget(
                  label: translation.unit_total_price,
                  value:
                      "${(cubit.state.paraPharmaCatalogData.unitPriceHt.toStringAsFixed(2))} ${translation.currency}",
                ),
                const ResponsiveGap.s12(),
                QuantitySectionModified(
                  quantityController: cubit.state.quantityController,
                  packageQuantityController:
                      cubit.state.packageQuantityController,
                  packageSize: cubit.state.paraPharmaCatalogData.packageSize,
                  disabledPackageQuantity: true,
                  decrementPackageQuantity: cubit.decrementPackageQuantity,
                  incrementPackageQuantity: cubit.incrementPackageQuantity,
                  incrementQuantity: cubit.incrementQuantity,
                  decrementQuantity: cubit.decrementQuantity,
                  onQuantityChanged: cubit.updateQuantity,
                  onPackageQuantityChanged: cubit.updateQuantityPackage,
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
                        "${(num.parse(cubit.state.quantityController.text) * cubit.state.paraPharmaCatalogData.unitPriceHt).toStringAsFixed(2)} ${translation.currency}",
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizesManager.p4),
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
                          onTap: () {
                            BlocProvider.of<CartCubit>(context)
                                .addToCart(
                                    CreateCartItemModel(
                                        productId: cubit
                                            .state.paraPharmaCatalogData.id,
                                        quantity: int.parse(cubit
                                            .state.quantityController.text),
                                        productType:
                                            ProductTypes.para_pharmacy),
                                    true)
                                .then((res) {
                              if (res) {
                                onAction?.call();
                              }
                            });
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
