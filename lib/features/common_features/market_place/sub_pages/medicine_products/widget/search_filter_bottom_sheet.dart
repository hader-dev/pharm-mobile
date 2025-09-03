import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/provider.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/widgets/pages/medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';

class SearchMedicineFilterBottomSheet extends StatefulWidget {
  const SearchMedicineFilterBottomSheet({super.key});

  @override
  State<SearchMedicineFilterBottomSheet> createState() =>
      _SearchMedicineFilterBottomSheetState();
}

class _SearchMedicineFilterBottomSheetState
    extends State<SearchMedicineFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MedicalFilterProvider(
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          if (state is! MedicineSearchFilterChanged) {}
          return MedicalFiltersView();
        },
      ),
    );
  }
}
