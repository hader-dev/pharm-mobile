import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';

import '../../../../../config/theme/colors_manager.dart' show AppColors;
import '../../../../../utils/constants.dart';

import '../../../para_pharma_catalog_details/widgets/make_order_bottom_sheet.dart' show InfoWidget;

import 'price_tag.dart' show PriceTag;

class PriceFilterSection extends StatelessWidget {
  const PriceFilterSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return InfoWidget(
          label: "Price: ",
          bgColor: AppColors.bgWhite,
          value: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  PriceTag(label: 'min', value: context.read<OrdersCubit>().minPriceFilter ?? 0),
                  PriceTag(label: 'max', value: context.read<OrdersCubit>().maxPriceFilter ?? 100000),
                ],
              ),
              const Gap(AppSizesManager.s12),
              RangeSlider(
                values: RangeValues(context.read<OrdersCubit>().minPriceFilter ?? 0,
                    context.read<OrdersCubit>().maxPriceFilter ?? 100000),
                min: 0,
                max: 100000,
                onChanged: (RangeValues values) {
                  context.read<OrdersCubit>().updatePriceFilter(minPrice: values.start, maxPrice: values.end);
                },
                activeColor: AppColors.accent1Shade1,
                inactiveColor: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }
}
