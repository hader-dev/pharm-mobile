import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/buttons/solid/primary_text_button.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/widgets/formatted_price.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/utils/bottom_sheet_helper.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

import 'select_payment_bottom_sheet.dart';

class DeligateItemsSummarySection extends StatelessWidget {
  final ValueNotifier<bool> isExpanded = ValueNotifier(true);
  DeligateItemsSummarySection({super.key});

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
                              AppSizesManager.commonWidgetsRadius),
                        ),
                      ),
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
                          BlocBuilder<DeligateCreateOrderCubit,
                              DeligateCreateOrderState>(
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
                      const Gap(
                        AppSizesManager.p8,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            context.translation!.total_ttc_amount,
                          ),
                          const Spacer(),
                          BlocBuilder<DeligateCreateOrderCubit,
                              DeligateCreateOrderState>(
                            builder: (context, state) {
                              return FormattedPrice(
                                price: num.parse(
                                    state.totalTtcAmount.toStringAsFixed(2)),
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
                          BlocBuilder<DeligateCreateOrderCubit,
                              DeligateCreateOrderState>(
                            builder: (context, state) {
                              return Text(
                                  "${((num.parse(state.totalTtcAmount.toStringAsFixed(2)) - num.parse(state.totalHtAmount.toStringAsFixed(2))) / 100).toStringAsFixed(2)} %",
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
                      BlocBuilder<DeligateCreateOrderCubit,
                          DeligateCreateOrderState>(builder: (context, state) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 32,
                          ),
                          child: PrimaryTextButton(
                            label: context.translation!.checkout,
                            onTap: state.orderProducts.isEmpty
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
