import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/filter_option_value.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../../main.dart' show translationContext;
import '../../../../utils/enums.dart';

import '../../../app_layout/app_layout.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../../../common/widgets/bottom_sheet_header.dart';
import '../../../common/widgets/info_widget.dart' show InfoWidget;

class SelectPaymentMethodBottomSheet extends StatelessWidget {
  const SelectPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>(),
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is PassOrderLoaded) {
            context.read<CartCubit>().clearCart();
            context.pop();
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is! InvoiceTypeChanged && state is! PaymentMethodChanged) {}
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BottomSheetHeader(title: context.translation!.checkoutProcess),
                  Gap(AppSizesManager.s12),
                  Divider(color: AppColors.bgDisabled, thickness: 1, height: 1),
                  Gap(AppSizesManager.s12),
                  InfoWidget(
                      label: context.translation!.paymentMethods,
                      bgColor: AppColors.bgWhite,
                      value: Column(
                        // shrinkWrap: true,
                        children: PaymentMethods.values
                            .map((paymentMethod) => FilterOptionValueWidget(
                                title: paymentMethod.name,
                                onSelected: () =>
                                    BlocProvider.of<CartCubit>(context).changePaymentMethod(paymentMethod),
                                isSelected: BlocProvider.of<CartCubit>(context).selectedPaymentMethod == paymentMethod))
                            .toList(),
                      )),
                  InfoWidget(
                      label: context.translation!.invoiceTypes,
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
                  InfoWidget(
                      label: context.translation!.orderNote,
                      bgColor: AppColors.bgWhite,
                      value: CustomTextField(
                        verticalPadding: 0,
                        horizontalPadding: AppSizesManager.p6,
                        initValue: context.read<CartCubit>().orderNote,
                        onChanged: (text) => context.read<CartCubit>().changeOrderNote(text ?? ''),
                        maxLines: 3,
                        validationFunc: (String? value) {},
                        isFilled: false,
                        isBorderEnabled: true,
                        hintText: context.translation!.typeNoteHint,
                        hintTextStyle: AppTypography.bodySmallStyle.copyWith(color: Colors.grey),
                      )),
                  Gap(AppSizesManager.s12),
                  InfoWidget(
                    label: context.translation!.totalAmount,
                    bgColor: AppColors.accentGreenShade3,
                    value: Row(
                      children: [
                        Text(
                          "${context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)} ${translationContext.currency}",
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
                    padding: EdgeInsets.symmetric(vertical: AppSizesManager.p4, horizontal: AppSizesManager.p4),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: PrimaryTextButton(
                            isOutLined: true,
                            label: context.translation!.cancel,
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
                            label: context.translation!.confirmOrder,
                            leadingIcon: Iconsax.money4,
                            onTap: () {
                              context.read<CartCubit>().passOrder();
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
      ),
    );
  }
}
