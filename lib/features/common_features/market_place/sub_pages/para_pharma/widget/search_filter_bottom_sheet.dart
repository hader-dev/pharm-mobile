import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/pages/para_medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';

class SearchParaPharmFilterBottomSheet extends StatefulWidget {
  const SearchParaPharmFilterBottomSheet({super.key});

  @override
  State<SearchParaPharmFilterBottomSheet> createState() =>
      _SearchParaPharmFilterBottomSheetState();
}

class _SearchParaPharmFilterBottomSheetState
    extends State<SearchParaPharmFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ParaPharmFilterProvider(
      child: BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
        builder: (context, state) {
          if (state is! ParaPharmaSearchFilterChanged) {}
          return ParaMedicalFiltersView();
        },
      ),
    );
  }
}
