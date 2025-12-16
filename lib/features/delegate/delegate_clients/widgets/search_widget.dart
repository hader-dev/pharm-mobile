import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/delegate/delegate_clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ClientDeligateSearchWidget extends StatelessWidget {
  const ClientDeligateSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.responsiveAppSizeTheme.current.p16),
      child: CustomTextField(
        hintText: context.translation!.search_clients,
        controller: BlocProvider.of<DelegateClientsCubit>(context).searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          size: context.responsiveAppSizeTheme.current.iconSize20,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            BlocProvider.of<DelegateClientsCubit>(context).searchController.clear();
            BlocProvider.of<DelegateClientsCubit>(context).searchClients();
          },
          child: Icon(
            Icons.clear,
            size: context.responsiveAppSizeTheme.current.iconSize20,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          BlocProvider.of<DelegateClientsCubit>(context).searchClients(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
