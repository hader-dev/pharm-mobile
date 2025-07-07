import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../utils/enums.dart';

import '../../../app_layout/app_layout.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/widgets/bottom_sheet_header.dart';
import '../../../common/widgets/info_widget.dart' show InfoWidget;

class SelectPaymentMethodBottomSheet extends StatelessWidget {
  const SelectPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is! InvoiceTypeChanged && state is! PaymentMethodChanged) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BottomSheetHeader(title: 'Checkout Process'),
              Gap(AppSizesManager.s12),
              Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
              Gap(AppSizesManager.s12),
              InfoWidget(
                  label: "Payment Methods",
                  bgColor: AppColors.bgWhite,
                  value: Column(
                    // shrinkWrap: true,
                    children: PaymentMethods.values
                        .map((paymentMethod) => FilterOptionValueWidget(
                            title: paymentMethod.name,
                            onSelected: () => BlocProvider.of<CartCubit>(context).changePaymentMethod(paymentMethod),
                            isSelected: BlocProvider.of<CartCubit>(context).selectedPaymentMethod == paymentMethod))
                        .toList(),
                  )),
              InfoWidget(
                  label: "Invoice Types",
                  bgColor: AppColors.bgWhite,
                  value: Column(
                    //shrinkWrap: true,
                    children: InvoiceTypes.values
                        .map((invoiceType) => FilterOptionValueWidget(
                            title: invoiceType.name,
                            onSelected: () => BlocProvider.of<CartCubit>(context).changeInvoiceType(invoiceType),
                            isSelected: BlocProvider.of<CartCubit>(context).selectedInvoiceType == invoiceType))
                        .toList(),
                  )),
              Gap(AppSizesManager.s12),
              InfoWidget(
                label: "Total Price",
                bgColor: AppColors.accentGreenShade3,
                value: Row(
                  children: [
                    Text(
                      "585 DZD",
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
                        onTap: () {},
                        borderColor: AppColors.accent1Shade1,
                      ),
                    ),
                    Gap(AppSizesManager.s8),
                    Expanded(
                      flex: 2,
                      child: PrimaryTextButton(
                        label: "Confirme Order",
                        leadingIcon: Iconsax.money4,
                        onTap: () {},
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
    );
  }
}
