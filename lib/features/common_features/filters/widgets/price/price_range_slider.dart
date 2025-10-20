import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class PriceRangeSlider extends StatelessWidget {
  final double? minPrice;
  final double? maxPrice;
  final Function(double min, double max) onChanged;
  final double minLimit;
  final double maxLimit;

  const PriceRangeSlider({
    super.key,
    this.minPrice,
    this.maxPrice,
    required this.onChanged,
    this.minLimit = 0,
    this.maxLimit = 100000,
  });

  @override
  Widget build(BuildContext context) {
    final range = RangeValues(minPrice ?? minLimit, maxPrice ?? maxLimit);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translation!.price_range_ht,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(AppSizesManager.p8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${range.start.toStringAsFixed(0)} ${context.translation!.currency_symbol}'),
            Text(
                '${range.end.toStringAsFixed(0)} ${context.translation!.currency_symbol}'),
          ],
        ),
        RangeSlider(
          values: range,
          min: minLimit,
          max: maxLimit,
          onChanged: (RangeValues values) {
            onChanged(values.start, values.end);
          },
        ),
      ],
    );
  }
}
