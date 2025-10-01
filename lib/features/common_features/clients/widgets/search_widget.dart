import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/text_fields/custom_text_field.dart';
import 'package:hader_pharm_mobile/features/common_features/clients/cubit/clients_cubit.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';
import 'package:iconsax/iconsax.dart';

class ClientDeligateSearchWidget extends StatelessWidget {
  const ClientDeligateSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizesManager.p16),
      child: CustomTextField(
        hintText: context.translation!.search_clients,
        controller:
            BlocProvider.of<DeligateClientsCubit>(context).searchController,
        state: FieldState.normal,
        isEnabled: true,
        prefixIcon: Icon(
          Iconsax.search_normal,
          color: AppColors.accent1Shade1,
        ),
        suffixIcon: InkWell(
          onTap: () {
            BlocProvider.of<DeligateClientsCubit>(context)
                .searchController
                .clear();
            BlocProvider.of<DeligateClientsCubit>(context).searchClients();
          },
          child: Icon(
            Icons.clear,
            color: AppColors.accent1Shade1,
          ),
        ),
        onChanged: (searchValue) {
          BlocProvider.of<DeligateClientsCubit>(context)
              .searchClients(searchValue);
        },
        validationFunc: (value) {},
      ),
    );
  }
}
