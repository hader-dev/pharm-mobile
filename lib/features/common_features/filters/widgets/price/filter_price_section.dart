import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FilterPriceSection extends StatefulWidget {
  final double? minPrice;
  final double? maxPrice;
  final Function(double min, double max) onChanged;
  final double minLimit;
  final double maxLimit;

  const FilterPriceSection({
    super.key,
    this.minPrice,
    this.maxPrice,
    required this.onChanged,
    this.minLimit = 0,
    this.maxLimit = 10000,
  });

  @override
  _FilterPriceSectionState createState() => _FilterPriceSectionState();
}

class _FilterPriceSectionState extends State<FilterPriceSection> {
  late RangeValues currentRangeValues;

  @override
  void initState() {
    super.initState();
    currentRangeValues = RangeValues(
      widget.minPrice ?? widget.minLimit,
      widget.maxPrice ?? widget.maxLimit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      label: "${context.translation!.price}: ",
      bgColor: AppColors.bgWhite,
      value: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PriceTag(
                  label: context.translation!.min,
                  value: currentRangeValues.start),
              PriceTag(
                  label: context.translation!.max,
                  value: currentRangeValues.end),
            ],
          ),
          const ResponsiveGap.s12(),
          RangeSlider(
            values: currentRangeValues,
            min: widget.minLimit,
            max: widget.maxLimit,
            activeColor: AppColors.accent1Shade1,
            inactiveColor: Colors.grey[300],
            onChanged: (values) {
              setState(() {
                currentRangeValues = values;
              });
            },
            onChangeEnd: (values) {
              widget.onChanged(values.start, values.end);
            },
          ),
        ],
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  final String label;
  final double value;

  const PriceTag({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '${value.toStringAsFixed(0)} ${context.translation!.currency}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
