import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/formatted_price.dart';
import 'package:hader_pharm_mobile/features/common_features/cart/cubit/cart_cubit.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'select_payment_bottom_sheet.dart';

class CartSummarySectionV1 extends StatelessWidget {
  const CartSummarySectionV1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
        buildWhen: (prev, curr) =>
            prev.isCartSummaryExpanded != curr.isCartSummaryExpanded,
        builder: (BuildContext context, CartState state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.responsiveAppSizeTheme.current.p8,
                vertical: context.responsiveAppSizeTheme.current.p16),
            child: Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(context.translation!.total_ht,
                            style: context.responsiveTextTheme.current.bodySmall
                                .copyWith(
                              color: Colors.grey[600],
                            )),
                        ResponsiveGap.s6(),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return FormattedPrice(
                              price: num.parse(
                                  state.totalHtAmount.toStringAsFixed(2)),
                              valueStyle: context
                                  .responsiveTextTheme.current.bodySmall
                                  .copyWith(
                                fontWeight: context.responsiveTextTheme.current
                                    .appFont.appFontBold,
                                color: Colors.grey[500],
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
                    ResponsiveGap.s6(),
                    Row(
                      children: [
                        Text(context.translation!.total_ttc,
                            style: context
                                .responsiveTextTheme.current.body2Medium
                                .copyWith(
                              color: Colors.black,
                              fontWeight: context.responsiveTextTheme.current
                                  .appFont.appFontBold,
                            )),
                        ResponsiveGap.s6(),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return FormattedPrice(
                              price: num.parse(
                                  state.totalTTCAmount.toStringAsFixed(2)),
                              valueStyle: context
                                  .responsiveTextTheme.current.body2Medium
                                  .copyWith(
                                fontWeight: context.responsiveTextTheme.current
                                    .appFont.appFontBold,
                                color: Colors.black,
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
                  ]),
              Spacer(),
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                return PrimaryTextButton(
                  label: context.translation!.checkout,
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                  onTap: state.cartItems.isEmpty
                      ? null
                      : () {
                          BottomSheetHelper.showCommonBottomSheet(
                              context: context,
                              child: SelectPaymentMethodBottomSheet());
                        },
                  color: AppColors.accent1Shade1,
                );
              }),
            ]),
          );
        });
  }
}
