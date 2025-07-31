import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/config/theme/typoghrapy_manager.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/cubit/wilaya_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/widgets/wilaya_dropdown.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class WilayaDropdown extends StatelessWidget {
  const WilayaDropdown({super.key, this.onChanged, this.validator});
  final OnWilayaCallback? onChanged;
  final WilayaValidator? validator;

  void handleSelectionChanged(Wilaya? selectedItem, WilayaCubit cubit) {
    cubit.updateSelectedWilaya(selectedItem);
    onChanged?.call(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WilayaCubit, WilayaState>(builder: (context, state) {
      final cubit = context.read<WilayaCubit>();
      cubit.loadWilayas();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSizesManager.p4),
            child: Text(context.translation!.wilaya,
                style: AppTypography.body3MediumStyle
                    .copyWith(color: TextColors.ternary.color)),
          ),
          const Gap(AppSizesManager.s6),
          BaseWilayaDropdown(
            validator: validator,
            wilayas: cubit.wilayas,
            currentSelection: cubit.selectedWilaya,
            onChanged: (selected) => handleSelectionChanged(selected, cubit),
          ),
          const Gap(AppSizesManager.s6),
        ],
      );
    });
  }
}
