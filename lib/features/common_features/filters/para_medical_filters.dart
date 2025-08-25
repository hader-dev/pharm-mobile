import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/views/parapharm/apply_filters_para_view.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/views/parapharm/browse_filters_para_medical.dart';

class ParaMedicalFiltersView extends StatelessWidget {
  const ParaMedicalFiltersView({super.key});

  final List<Widget> screens = const [
    FiltersParaMedicalBrowse(),
    ParaMedicalFiltersApply(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
      builder: (context, state) {
        return IndexedStack(
          index: BlocProvider.of<ParaMedicalFiltersCubit>(context).pageIndex,
          children: screens,
        );
      }
    );
  }
}
