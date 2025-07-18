import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../utils/enums.dart';
import '../../../app_layout/app_layout.dart';
import '../../../common/buttons/solid/primary_icon_button.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/widgets/bottom_sheet_header.dart';
import '../../orders/cubit/orders_cubit.dart';
import '../cubit/para_pharma_details_cubit.dart';
import '../para_pharma_catalog_details.dart' show ParaPharmaCatalogDetailsScreen;

class MakeOrderBottomSheet extends StatelessWidget {
  const MakeOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: ParaPharmaCatalogDetailsScreen.paraPharmaDetailsScaffoldKey.currentContext!
              .read<ParaPharmaDetailsCubit>(),
        ),
        BlocProvider.value(value: AppLayout.appLayoutScaffoldKey.currentContext!.read<OrdersCubit>()),
      ],
      child: BlocListener<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
        listener: (context, state) {
          if (state is QuickOrderPassed) {
            context.read<OrdersCubit>().getOrders();
            context.pop();
          }
        },
        child: BlocBuilder<ParaPharmaDetailsCubit, ParaPharmaDetailsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(title: 'Make an order'),
                Gap(AppSizesManager.s12),
                LabeledInfoWidget(
                  label: "Product",
                  value: context.read<ParaPharmaDetailsCubit>().paraPharmaCatalogData!.name,
                ),
                LabeledInfoWidget(
                  label: "Unit Total Price",
                  value:
                      "${(num.parse(context.read<ParaPharmaDetailsCubit>().paraPharmaCatalogData!.unitPriceHt).toStringAsFixed(2))} DZD",
                ),
                Gap(AppSizesManager.s12),
                Text(
                  'Quantity',
                  style: AppTypography.body3MediumStyle.copyWith(
                    color: TextColors.ternary.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizesManager.p8),
                  child: Row(children: [
                    PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: () {
                        context.read<ParaPharmaDetailsCubit>().decrementQuantity();
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
                              controller: context.read<ParaPharmaDetailsCubit>().quantityController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) => value == null || value.isEmpty ? '' : null,
                              style: AppTypography.body3MediumStyle,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(AppSizesManager.p12),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
                                  borderSide: BorderSide(color: FieldState.normal.color.secondary),
                                ),
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
                    Spacer(),
                    PrimaryIconButton(
                      borderColor: StrokeColors.normal.color,
                      isBordered: true,
                      bgColor: Colors.transparent,
                      onPressed: () {
                        context.read<ParaPharmaDetailsCubit>().incrementQuantity();
                      },
                      icon: Icon(
                        Iconsax.add,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                Gap(AppSizesManager.s12),
                Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                Gap(AppSizesManager.s12),
                InfoWidget(
                  label: "Total Price",
                  bgColor: AppColors.accentGreenShade3,
                  value: Row(
                    children: [
                      Text(
                        "${(num.parse(context.read<ParaPharmaDetailsCubit>().quantityController.text) * num.parse(context.read<ParaPharmaDetailsCubit>().paraPharmaCatalogData!.unitPriceHt)).toStringAsFixed(2)} DZD",
                        style: AppTypography.body2MediumStyle.copyWith(color: AppColors.accent1Shade1),
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
                          label: "Cancel",
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
                          label: "Buy now",
                          leadingIcon: Iconsax.money4,
                          isLoading: state is PassingQuickOrder,
                          onTap: () {
                            context.read<ParaPharmaDetailsCubit>().passQuickOrder();
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
        borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
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
