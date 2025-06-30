import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../../config/theme/colors_manager.dart';
import '../../../../utils/constants.dart';
import '../../../common/widgets/formatted_price.dart';
import '../cubit/cart_cubit.dart';

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
                      // Row(
                      //   children: <Widget>[
                      //     Text(
                      //       context.translation!.total_ht_amount,
                      //       style: context.theme.textTheme.bodySmall!
                      //           .copyWith(fontSize: AppTypography.appFontSize5, color: Colors.grey[600]),
                      //     ),
                      //     const Spacer(),
                      //     BlocBuilder<CartCubit, CartState>(
                      //       builder: (context, state) {
                      //         return FormattedPrice(
                      //           price: double.parse(context.read<CartCubit>().totalHtAmount.toStringAsFixed(2)),
                      //           valueStyle: context.theme.textTheme.headlineSmall!.copyWith(
                      //             fontSize: AppTypography.appFontSize4,
                      //             fontWeight: AppTypography.appFontBold,
                      //             color: Colors.grey,
                      //           ),
                      //           unitStyle: TextStyle(
                      //             color: AppColorsPallette.lightAccentsColors[3],
                      //             fontSize: AppTypography.appFontSize6,
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // const Gap(
                      //   height: AppSizesManager.smallPadding,
                      // ),
                      // Text(
                      //   '---------------------------------------',
                      //   style: TextStyle(letterSpacing: 1.5, color: Colors.grey.withOpacity(0.5)),
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Text(
                      //       context.translation!.total_ttc_amount,
                      //       style: context.theme.textTheme.bodySmall!
                      //           .copyWith(fontSize: AppTypography.appFontSize5, color: Colors.grey[600]),
                      //     ),
                      //     const Spacer(),
                      //     BlocBuilder<CartCubit, CartState>(
                      //       builder: (BuildContext context, CartState state) {
                      //         return FormattedPrice(
                      //           price: double.parse(context.read<CartCubit>().totalTTCAmount.toStringAsFixed(2)),
                      //           valueStyle: context.theme.textTheme.headlineSmall!.copyWith(
                      //             fontSize: AppTypography.appFontSize4,
                      //             fontWeight: AppTypography.appFontBold,
                      //             color: Colors.black,
                      //           ),
                      //           unitStyle: TextStyle(
                      //             color: AppColorsPallette.lightAccentsColors[3],
                      //             fontSize: AppTypography.appFontSize6,
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // BlocBuilder<CartCubit, CartState>(
                      //   builder: (context, state) {
                      //     return context.read<CartCubit>().selectedItems.isNotEmpty
                      //         ? Padding(
                      //             padding: const EdgeInsets.symmetric(vertical: AppSizesManager.mediumPadding),
                      //             child: BlocBuilder<CartCubit, CartState>(
                      //               builder: (BuildContext context, CartState state) {
                      //                 final int selectedCount = context.read<CartCubit>().selectedItems.length;
                      //                 return CommonButton(
                      //                   labelColor: Colors.white,
                      //                   height: 45,
                      //                   minWidth: double.maxFinite,
                      //                   label:
                      //                       '${context.translation!.checkout}${selectedCount == 0 ? '' : " ($selectedCount)"}',
                      //                   color: AppColorsPallette.primaryColors.first,
                      //                   onTap: () {
                      //                     if (selectedCount == 0) {
                      //                       Fluttertoast.showToast(
                      //                         msg: 'Please select at least one item to checkout.',
                      //                         toastLength: Toast.LENGTH_SHORT,
                      //                         gravity: ToastGravity.BOTTOM,
                      //                         textColor: Colors.black,
                      //                       );
                      //                       return;
                      //                     }
                      //                     GoRouter.of(context).pushNamed(RoutingManager.checkOutScreen,
                      //                         extra: context.read<CartCubit>().selectedItems);
                      //                   },
                      //                 );
                      //               },
                      //             ),
                      //           )
                      //         : const Gap.shrink();
                      //   },
                      // ),
// ...existing code...
// ...existing code...
                    ]),
            ),
          );
        });
  }
}
