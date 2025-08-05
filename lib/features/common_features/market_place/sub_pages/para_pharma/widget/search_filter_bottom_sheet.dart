import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/filters_repository_impl.dart';


class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final medicineCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
            .read<MedicineProductsCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ParaMedicalFiltersCubit(
            filtersRepository: FiltersRepositoryImpl(),
          )..loadParaMedicalFilters(),
        ),
        BlocProvider.value(
          value: medicineCubit,
        ),
      ],
      child: BlocBuilder<MedicineProductsCubit, MedicineProductsState>(
        builder: (context, state) {
          if (state is! ParaPharmaSearchFilterChanged) {}
          return MedicalFiltersView();
        },
      ),
    );
  }
}
