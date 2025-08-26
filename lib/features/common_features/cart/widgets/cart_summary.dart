import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/bottom_sheet_helper.dart';
import '../../../../utils/constants.dart';
import '../../../common/buttons/solid/primary_text_button.dart';
import '../../../common/widgets/formatted_price.dart';
import '../cubit/cart_cubit.dart';
import 'select_payment_bottom_sheet.dart';

class CartSummarySection extends StatelessWidget {
  final ValueNotifier<bool> isExpanded = ValueNotifier(true);
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
                        context.translation!.summary,
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_up_sharp,
                          color: AppColors.accent1Shade1,
                          size: AppSizesManager.iconSize20),
                    ])
                  : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                  AppSizesManager.commonWidgetsRadius))),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: AppSizesManager.p10,
                            bottom: AppSizesManager.p10),
                        child: Row(
                          children: <Widget>[
                            const Spacer(),
                            Icon(Icons.close,
                                color: AppColors.accent1Shade1,
                                size: AppSizesManager.iconSize20),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            context.translation!.total_ht_amount,
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(context
                                    .read<CartCubit>()
                                    .totalHtAmount
                                    .toStringAsFixed(2)),
                                valueStyle: context
                                    .responsiveTextTheme.current.body3Medium
                                    .copyWith(
                                  fontWeight: context.responsiveTextTheme
                                      .current.appFont.appFontBold,
                                  color: Colors.grey[600],
                                ),
                                unitStyle: context
                                    .responsiveTextTheme.current.bodyXSmall
                                    .copyWith(
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
                            context.translation!.total_ttc_amount,
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(context
                                    .read<CartCubit>()
                                    .totalTTCAmount
                                    .toStringAsFixed(2)),
                                valueStyle: context
                                    .responsiveTextTheme.current.body3Medium
                                    .copyWith(
                                  fontWeight: context.responsiveTextTheme
                                      .current.appFont.appFontBold,
                                  color: Colors.grey[600],
                                ),
                                unitStyle: context
                                    .responsiveTextTheme.current.bodyXSmall
                                    .copyWith(
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
                            '${context.translation!.tva} (%)',
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return Text(
                                  "${((num.parse(context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)) - num.parse(context.read<CartCubit>().totalHtAmount.toStringAsFixed(2))) / 100).toStringAsFixed(2)} %",
                                  style: context
                                      .responsiveTextTheme.current.body3Medium
                                      .copyWith(
                                    fontWeight: context.responsiveTextTheme
                                        .current.appFont.appFontBold,
                                    color: Colors.grey[600],
                                  ));
                            },
                          ),
                        ],
                      ),
                      Gap(AppSizesManager.s8), // Reduced gap
                      BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 32, // Ensure button fits
                          ),
                          child: PrimaryTextButton(
                            label: context.translation!.checkout,
                            onTap: context.read<CartCubit>().cartItems.isEmpty
                                ? null
                                : () {
                                    BottomSheetHelper.showCommonBottomSheet(
                                        context: context,
                                        child: SelectPaymentMethodBottomSheet());
                                  },
                            color: AppColors.accent1Shade1,
                          ),
                        );
                      }),
                    ]),
            ),
          );
        });
  }
}
