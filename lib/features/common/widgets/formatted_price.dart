import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:intl/intl.dart';


class FormattedPrice extends StatelessWidget {
  final num price;
  final TextStyle valueStyle;
  final TextStyle unitStyle;

  const FormattedPrice({
    super.key,
    required this.price,
    required this.valueStyle,
    required this.unitStyle,
  });

  @override
  Widget build(BuildContext context) {
    final formatted = NumberFormat.currency(
      decimalDigits: 2,
      symbol: '',
    ).format(price);
    return Text.rich(
      TextSpan(
        text: formatted,
        style: valueStyle,
        children: [
          TextSpan(
            text: ' ${context.translation!.currency}',
            style: unitStyle,
          ),
        ],
      ),
    );
  }
}
