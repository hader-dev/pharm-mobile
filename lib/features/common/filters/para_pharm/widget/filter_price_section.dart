import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/filters/para_pharm/cubit/para_pharm_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class FilterPriceSection extends StatefulWidget {
  final double? minPrice;
  final double? maxPrice;

  const FilterPriceSection({
    super.key,
    this.minPrice = 0,
    this.maxPrice = 0,
  });

  @override
  FilterPriceSectionState createState() => FilterPriceSectionState();
}

class FilterPriceSectionState extends State<FilterPriceSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParaPharmFiltersCubit, ParaPharmFiltersState>(
      builder: (context, state) {
        final ParaPharmFiltersCubit cubit = context.read<ParaPharmFiltersCubit>();
        return InfoWidget(
          label: "${context.translation!.price}: ",
          bgColor: AppColors.bgWhite,
          value: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(child: PriceTag(tag: 'min', label: context.translation!.min, value: widget.minPrice ?? 0)),
                  const ResponsiveGap.s12(),
                  Flexible(child: PriceTag(tag: 'max', label: context.translation!.max, value: widget.maxPrice ?? 0)),
                ],
              ),
              ResponsiveGap.s2(),
              if (cubit.tempFilters.minPriceFilter > cubit.tempFilters.maxPriceFilter)
                Text(
                  "min price should be less than max",
                  style: context.responsiveTextTheme.current.body3Medium.copyWith(color: SystemColors.red.primary),
                ),
            ],
          ),
        );
      },
    );
  }
}

class PriceTag extends StatelessWidget {
  final String tag;
  final String label;
  final double value;

  const PriceTag({
    super.key,
    required this.label,
    required this.value,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.responsiveTextTheme.current.body3Medium),
        const ResponsiveGap.s4(),
        CustomTextField(
          initValue: value.toString(),
          keyBoadType: TextInputType.number,
          formatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            if (tag == 'min') {
              context
                  .read<ParaPharmFiltersCubit>()
                  .changeFilters(context.read<ParaPharmFiltersCubit>().tempFilters.copyWith(
                        minPriceFilter: double.parse(value ?? "0"),
                      ));
            }

            if (tag == 'max') {
              context
                  .read<ParaPharmFiltersCubit>()
                  .changeFilters(context.read<ParaPharmFiltersCubit>().tempFilters.copyWith(
                        maxPriceFilter: double.parse(value ?? "0"),
                      ));
            }
          },
        )
      ],
    );
  }
}
