import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/config/theme/colors_manager.dart';
import 'package:hader_pharm_mobile/features/common/spacers/responsive_gap.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/cubit/wilaya_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/wilaya/widgets/wilaya_dropdown.dart';
import 'package:hader_pharm_mobile/models/wilaya.dart';
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
            padding: EdgeInsets.only(
                left: context.responsiveAppSizeTheme.current.p4),
            child: Text(context.translation!.wilaya,
                style: context.responsiveTextTheme.current.body3Medium
                    .copyWith(color: TextColors.ternary.color)),
          ),
          const ResponsiveGap.s6(),
          BaseWilayaDropdown(
            validator: validator,
            wilayas: state.wilayas,
            currentSelection: state.selectedWilaya,
            onChanged: (selected) => handleSelectionChanged(selected, cubit),
          ),
          const ResponsiveGap.s6(),
        ],
      );
    });
  }
}
