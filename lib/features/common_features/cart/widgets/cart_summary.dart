import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/bottom_sheet_helper.dart';
import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/widgets/formatted_price.dart';
import '../cubit/cart_cubit.dart';
import 'select_payment_bottom_sheet.dart';

class CartSummarySection extends StatelessWidget {
  ValueNotifier<bool> isExpanded = ValueNotifier(true);
  CartSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isExpanded,
        builder: (BuildContext context, bool value, Widget? child) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: Container(
              margin: const EdgeInsets.all(AppSizesManager.p8),
              padding: const EdgeInsets.all(AppSizesManager.p12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizesManager.commonWidgetsRadius),
                ),
              ),
              child: !isExpanded.value
                  ? Row(children: <Widget>[
                      Text(
                        "Summary",
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_up_sharp,
                          color: AppColors.accent1Shade1, size: AppSizesManager.iconSize20),
                    ])
                  : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(AppSizesManager.commonWidgetsRadius))),
                      Padding(
                        padding: const EdgeInsets.only(top: AppSizesManager.p10, bottom: AppSizesManager.p10),
                        child: Row(
                          children: <Widget>[
                            const Spacer(),
                            Icon(Icons.close, color: AppColors.accent1Shade1, size: AppSizesManager.iconSize20),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Total HT Amount',
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(context.read<CartCubit>().totalHtAmount.toStringAsFixed(2)),
                                valueStyle: AppTypography.body3MediumStyle.copyWith(
                                  fontWeight: AppTypography.appFontBold,
                                  color: Colors.grey[600],
                                ),
                                unitStyle: AppTypography.bodyXSmallStyle.copyWith(
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(
                        AppSizesManager.p8,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Total Ttc Amount',
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)),
                                valueStyle: AppTypography.body3MediumStyle.copyWith(
                                  fontWeight: AppTypography.appFontBold,
                                  color: Colors.grey[600],
                                ),
                                unitStyle: AppTypography.bodyXSmallStyle.copyWith(
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(
                        AppSizesManager.p8,
                      ),
                      const Gap(
                        AppSizesManager.p8,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Tva (%)',
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return Text(
                                  "${((num.parse(context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)) - num.parse(context.read<CartCubit>().totalHtAmount.toStringAsFixed(2))) / 100).toStringAsFixed(2)} %",
                                  style: AppTypography.body3MediumStyle.copyWith(
                                    fontWeight: AppTypography.appFontBold,
                                    color: Colors.grey[600],
                                  ));
                            },
                          ),
                        ],
                      ),
                      Gap(AppSizesManager.s12),
                      BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                        return PrimaryTextButton(
                          label: "checkout",
                          onTap: context.read<CartCubit>().cartItems.isEmpty
                              ? null
                              : () {
                                  BottomSheetHelper.showCommonBottomSheet(
                                      context: context, child: SelectPaymentMethodBottomSheet());
                                },
                          color: AppColors.accent1Shade1,
                        );
                      }),
                    ]),
            ),
          );
        });
  }
}
