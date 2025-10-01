import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/widgets/search_widget.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class AddItemsSections extends StatelessWidget {
  const AddItemsSections({super.key});

  @override
  Widget build(BuildContext context) {
    final translation = context.translation!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          translation.add_products_to_order,
          style: context.responsiveTextTheme.current.headLine4SemiBold
              .copyWith(color: AppColors.accent1Shade1),
        ),
        const CreateOrderSearchWidget(),
        const Divider(
          color: AppColors.accent1Shade1,
        ),
      ],
    );
  }
}
