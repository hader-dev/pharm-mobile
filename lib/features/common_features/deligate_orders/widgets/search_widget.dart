import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/orders/cubit/orders_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class DeligateOrdersSearchWidget extends StatelessWidget {
  const DeligateOrdersSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OrdersCubit>(context);

    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      child: CustomTextField(
        hintText: context.translation!.search_orders,
        controller: cubit.searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            cubit.searchController.clear();
            cubit.searchOrders();
          },
          child: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          cubit.searchOrders(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
