import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hader_pharm_mobile/config/di/di.dart';
import 'package:hader_pharm_mobile/config/services/auth/user_manager.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/widgets/invoice_input.dart';
import 'package:hader_pharm_mobile/features/common/widgets/payment_input.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/toast_helper.dart';
import 'package:hader_pharm_mobile/utils/validators.dart';
import 'package:iconsax/iconsax.dart' show Iconsax;

import '../../../app_layout/app_layout.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/text_fields/custom_text_field.dart';
import '../../../common/widgets/bottom_sheet_header.dart';
import '../../../common/widgets/info_widget.dart' show InfoWidget;

class SelectPaymentMethodBottomSheet extends StatelessWidget {
  const SelectPaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return BlocProvider.value(
      value: AppLayout.appLayoutScaffoldKey.currentContext!.read<CartCubit>(),
      child: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is PassOrderLoaded) {
            context.read<CartCubit>().clearCart(context.translation!);
            AppLayout.appLayoutScaffoldKey.currentContext!
                .read<OrdersCubit>()
                .getOrders();
            context.pop();
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is! InvoiceTypeChanged &&
                state is! PaymentMethodChanged) {}
            return Form(
              key: context.read<CartCubit>().formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BottomSheetHeader(
                        title: context.translation!.checkout_process),
                    Gap(AppSizesManager.s12),
                    Divider(
                        color: AppColors.bgDisabled, thickness: 1, height: 1),
                    Gap(AppSizesManager.s12),
                    InfoWidget(
                        label: context.translation!.payment_methods,
                        bgColor: AppColors.bgWhite,
                        value: PaymentRadioInput(
                          validator: (v) =>
                              requiredValidator(v?.name, translation),
                        )),
                    InfoWidget(
                        label: context.translation!.invoice_types,
                        bgColor: AppColors.bgWhite,
                        value: InvoiceRadioInput(
                          validator: (v) =>
                              requiredValidator(v?.name, translation),
                        )),
                    InfoWidget(
                        label: context.translation!.shipping_address,
                        bgColor: AppColors.bgWhite,
                        value: CustomTextField(
                          verticalPadding: 0,
                          horizontalPadding: AppSizesManager.p6,
                          initValue: UserManager.instance.currentUser.address,
                          onChanged: (text) => context
                              .read<CartCubit>()
                              .updateShippingAddress(text ?? ''),
                          maxLines: 3,
                          validationFunc: (value) =>
                              requiredValidator(value, translation),
                          isFilled: false,
                          isBorderEnabled: true,
                          hintText: context.translation!.shipping_address,
                          hintTextStyle: context
                              .responsiveTextTheme.current.bodySmall
                              .copyWith(color: Colors.grey),
                        )),
                    InfoWidget(
                        label: context.translation!.order_note,
                        bgColor: AppColors.bgWhite,
                        value: CustomTextField(
                          verticalPadding: 0,
                          horizontalPadding: AppSizesManager.p6,
                          initValue: context.read<CartCubit>().orderNote,
                          onChanged: (text) => context
                              .read<CartCubit>()
                              .changeOrderNote(text ?? ''),
                          maxLines: 3,
                          validationFunc: (String? value) {},
                          isFilled: false,
                          isBorderEnabled: true,
                          hintText: context.translation!.type_note_hint,
                          hintTextStyle: context
                              .responsiveTextTheme.current.bodySmall
                              .copyWith(color: Colors.grey),
                        )),
                    Gap(AppSizesManager.s12),
                    InfoWidget(
                      label: context.translation!.total_amount,
                      bgColor: AppColors.accentGreenShade3,
                      value: Row(
                        children: [
                          Text(
                            "${context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)} ${context.translation!.currency}",
                            style: context
                                .responsiveTextTheme.current.body2Medium
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
                    Divider(
                        color: AppColors.bgDisabled, thickness: 1, height: 1),
                    Gap(AppSizesManager.s12),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizesManager.p4,
                          horizontal: AppSizesManager.p4),
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
                              label: context.translation!.confirm_order,
                              leadingIcon: Iconsax.money4,
                              onTap: () {
                                context.read<CartCubit>().passOrder();

                                getItInstance.get<ToastManager>().showToast(
                                      message: context.translation!
                                          .order_placed_successfully,
                                      type: ToastType.success,
                                    );
                              },
                              color: AppColors.accent1Shade1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
