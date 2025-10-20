import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/pdf_viewer/para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FilterPriceSection extends StatelessWidget {
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
    this.maxLimit = 1000,
  });

  @override
  Widget build(BuildContext context) {
    RangeValues currentRangeValues = RangeValues(
      minPrice ?? minLimit,
      maxPrice ?? maxLimit,
    );

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
            min: minLimit,
            max: maxLimit,
            onChanged: (RangeValues values) {},
            onChangeEnd: (RangeValues values) {
              onChanged(values.start, values.end);
            },
            activeColor: AppColors.accent1Shade1,
            inactiveColor: Colors.grey[300],
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
