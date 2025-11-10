import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/formatted_price.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'select_payment_bottom_sheet.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    return BlocBuilder<CartCubit, CartState>(
        buildWhen: (prev, curr) =>
            prev.isCartSummaryExpanded != curr.isCartSummaryExpanded,
        builder: (BuildContext context, CartState state) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              cubit.toggleCartSummary();
            },
            child: Container(
              margin: EdgeInsets.all(context.responsiveAppSizeTheme.current.p8),
              padding:
                  EdgeInsets.all(context.responsiveAppSizeTheme.current.p12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.all(
                  Radius.circular(context
                      .responsiveAppSizeTheme.current.commonWidgetsRadius),
                ),
              ),
              child: !state.isCartSummaryExpanded
                  ? Row(children: <Widget>[
                      Text(
                        context.translation!.summary,
                        style: context.responsiveTextTheme.current.body3Medium
                            .copyWith(
                          fontWeight: context
                              .responsiveTextTheme.current.appFont.appFontBold,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_up_sharp,
                          color: AppColors.accent1Shade1,
                          size: context
                              .responsiveAppSizeTheme.current.iconSize20),
                    ])
                  : Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(context
                              .responsiveAppSizeTheme
                              .current
                              .commonWidgetsRadius),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: context.responsiveAppSizeTheme.current.p10,
                            bottom: context.responsiveAppSizeTheme.current.p10),
                        child: Row(
                          children: <Widget>[
                            const Spacer(),
                            Icon(Icons.close,
                                color: AppColors.accent1Shade1,
                                size: context
                                    .responsiveAppSizeTheme.current.iconSize20),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            context.translation!.total_ht_amount,
                            style: context
                                .responsiveTextTheme.current.body3Medium
                                .copyWith(
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontBold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(
                                    state.totalHtAmount.toStringAsFixed(2)),
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
                      Gap(
                        context.responsiveAppSizeTheme.current.p8,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            context.translation!.total_ttc_amount,
                            style: context
                                .responsiveTextTheme.current.body3Medium
                                .copyWith(
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontBold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(
                                    state.totalTTCAmount.toStringAsFixed(2)),
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
                      Gap(
                        context.responsiveAppSizeTheme.current.p8,
                      ),
                      Gap(
                        context.responsiveAppSizeTheme.current.p8,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${context.translation!.tva} (%)',
                            style: context
                                .responsiveTextTheme.current.body3Medium
                                .copyWith(
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontBold,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              return Text(
                                  "${((num.parse(state.totalTTCAmount.toStringAsFixed(2)) - num.parse(state.totalHtAmount.toStringAsFixed(2))) / 100).toStringAsFixed(2)} %",
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
                      const ResponsiveGap.s8(),
                      BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 32,
                          ),
                          child: PrimaryTextButton(
                            label: context.translation!.checkout,
                            onTap: state.cartItems.isEmpty
                                ? null
                                : () {
                                    BottomSheetHelper.showCommonBottomSheet(
                                        context: context,
                                        child:
                                            SelectPaymentMethodBottomSheet());
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
