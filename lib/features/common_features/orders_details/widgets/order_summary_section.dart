import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:hader_pharm_mobile/utils/extensions/price_formatter.dart';

import '../../../../config/theme/typography/typoghrapy_source.dart';
import '../../../../utils/constants.dart';
import '../cubit/orders_details_cubit.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    OrderDetailsCubit cubit = context.read<OrderDetailsCubit>();
    return Container(
      margin: const EdgeInsets.all(AppSizesManager.p4),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizesManager.p8, horizontal: AppSizesManager.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(AppSizesManager.commonWidgetsRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.translation!.order_summary,
            style: context.responsiveTextTheme.current.headLine4SemiBold,
          ),
          const Gap(AppSizesManager.s12),

          SummaryRow(
            label: context.translation!.payment_method,
            value: PaymentMethods.values
                .firstWhere(
                    (element) =>
                        element.id ==
                        context
                            .read<OrderDetailsCubit>()
                            .orderData!
                            .paymentMethod,
                    orElse: () => PaymentMethods.cash)
                .translation(context.translation!),
          ),
          // SummaryRow(label: context.translation!.discount, value: cubit.orderData!.discount.formatAsPercentage()),
          //   const SummaryRow(label: 'Shipping (Standard)', value: '10.00 context.translation!.currencyAbbreviation'),
          SummaryRow(
              label: context.translation!.total_ht,
              value:
                  cubit.orderData!.totalAmountExclTax.formatAsPriceForPrint()),
          SummaryRow(
              label: context.translation!.total_ttc,
              value:
                  cubit.orderData!.totalAmountInclTax.formatAsPriceForPrint()),
          // const Divider(height: 24, thickness: 1),
          // SummaryRow(
          //   label: context.translation!.total_ht_amount,
          //   value: '${cubit.orderDetails!.amountHt.formatAsPrice()} ${context.translation!.currencyAbbreviation}',
          // ),
          // SummaryRow(
          //   label: context.translation!.total_ttc_amount,
          //   value: '${cubit.orderDetails!.netAmountTtc.formatAsPrice()} ${context.translation!.currencyAbbreviation}',
          // ),
          // SummaryRow(
          //     label: context.translation!.total_amount,
          //     value: '${cubit.orderDetails!.netToPay.formatAsPrice()} ${context.translation!.currencyAbbreviation}',
          //     isBold: true),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: isBold
                  ? context.responsiveTextTheme.current.appFont.headLine4
                  : AppTypographySource.headLine5,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold
                  ? context.responsiveTextTheme.current.appFont.headLine4
                  : AppTypographySource.headLine5,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
