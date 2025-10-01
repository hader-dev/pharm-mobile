import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/deligate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CreateOrderSearchWidget extends StatelessWidget {
  const CreateOrderSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p16),
      child: CustomTextField(
        hintText: context.translation!.search_products,
        controller:
            BlocProvider.of<DeligateCreateOrderCubit>(context).searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            BlocProvider.of<DeligateCreateOrderCubit>(context)
                .searchController
                .clear();
            BlocProvider.of<DeligateCreateOrderCubit>(context).searchProducts();
          },
          child: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          BlocProvider.of<DeligateCreateOrderCubit>(context)
              .searchProducts(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
