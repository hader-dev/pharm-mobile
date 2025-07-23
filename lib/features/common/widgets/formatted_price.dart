import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../main.dart' show translationContext;

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
            text: ' ${translationContext.currency}',
            style: unitStyle,
          ),
        ],
      ),
    );
  }
}
