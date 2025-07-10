import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';

import '../../../../../utils/constants.dart';

import '../../../../common/widgets/formatted_price.dart' show FormattedPrice;

class PriceTag extends StatelessWidget {
  const PriceTag({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          '$label:',
          style: AppTypography.headLine5MediumStyle,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSizesManager.p6, vertical: AppSizesManager.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: FormattedPrice(
            price: double.parse(value.toStringAsFixed(1)),
            valueStyle: AppTypography.headLine4SemiBoldStyle,
            unitStyle: AppTypography.bodyXSmallStyle.copyWith(fontSize: AppTypography.bodyXXSmall),
          ),
        ),
      ],
    );
  }
}
