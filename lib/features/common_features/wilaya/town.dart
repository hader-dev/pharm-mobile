import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/cubit/wilaya_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/widgets/town_dropdown.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
import 'package:hader_pharm_mobile/utils/constants.dart';
import 'package:hader_pharm_mobile/utils/extensions/app_context_helper.dart';

class TownDropdown extends StatelessWidget {
  const TownDropdown(
      {super.key, this.onChanged, this.isRequired = false, this.validator});
  final OnChangedCallback? onChanged;
  final TownValidator? validator;
  final bool isRequired;

  void handleSelectionChanged(Town? selectedItem, WilayaCubit cubit) {
    cubit.updateSelectedTown(selectedItem);
    onChanged?.call(selectedItem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WilayaCubit, WilayaState>(builder: (context, state) {
      final cubit = context.read<WilayaCubit>();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSizesManager.p4),
            child: Text("${context.translation!.town} ${isRequired ? "*" : ""}",
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: TextColors.ternary.color)),
          ),
          const ResponsiveGap.s6(),
          BaseTownDropdown(
            validator: validator,
            towns: cubit.towns,
            currentSelection: cubit.selectedTown,
            onChanged: (selected) => handleSelectionChanged(selected, cubit),
          ),
          const ResponsiveGap.s6(),
        ],
      );
    });
  }
}
