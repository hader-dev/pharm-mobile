import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_create_order/cubit/create_order_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class CreateOrderSearchWidget extends StatelessWidget {
  const CreateOrderSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      child: CustomTextField(
        hintText: context.translation!.search_products,
        controller: BlocProvider.of<DelegateCreateOrderCubit>(context).state.searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          size: context.responsiveAppSizeTheme.current.iconSize20,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            BlocProvider.of<DelegateCreateOrderCubit>(context).state.searchController.clear();
            BlocProvider.of<DelegateCreateOrderCubit>(context).searchProducts();
          },
          child: Icon(
            Icons.clear,
            size: context.responsiveAppSizeTheme.current.iconSize20,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          BlocProvider.of<DelegateCreateOrderCubit>(context).searchProducts(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
