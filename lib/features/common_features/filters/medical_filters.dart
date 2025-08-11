import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/views/apply_filters_medical-view.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/views/browse_filters_medical.dart';
class MedicalFiltersView extends StatelessWidget {
  const MedicalFiltersView({super.key});

  final List<Widget> screens = const [
    FiltersMedicalBrowse(),
    MedicalFiltersApply(),
  ];

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<MedicalFiltersCubit, MedicalFiltersState>(
          builder: (context,state) {
            return IndexedStack(
              index: BlocProvider.of<MedicalFiltersCubit>(context).pageIndex,
              children: screens,
            );
          }
        );

  }
}
