import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class PriceRangeSlider extends StatefulWidget {
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
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      widget.minPrice ?? widget.minLimit,
      widget.maxPrice ?? widget.maxLimit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translation!.price_range_ht,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_currentRangeValues.start.toStringAsFixed(0)} ${context.translation!.currency_symbol}'),
            Text('${_currentRangeValues.end.toStringAsFixed(0)} ${context.translation!.currency_symbol}'),
          ],
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: widget.minLimit,
          max: widget.maxLimit,
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
            widget.onChanged(values.start, values.end);
          },
        ),
      ],
    );
  }
}