import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/para_medical_filters.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/market_place.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';
import 'package:hader_pharm_mobile/repositories/locale/filters/filters_repository_impl.dart';


class SearchParaPharmFilterBottomSheet extends StatefulWidget {
  const SearchParaPharmFilterBottomSheet({super.key});

  @override
  State<SearchParaPharmFilterBottomSheet> createState() =>
      _SearchParaPharmFilterBottomSheetState();
}

class _SearchParaPharmFilterBottomSheetState extends State<SearchParaPharmFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final medicineCubit = MarketPlaceScreen.marketPlaceScaffoldKey.currentContext!
            .read<ParaPharmaCubit>();

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
      child: BlocBuilder<ParaMedicalFiltersCubit, ParaMedicalFiltersState>(
        builder: (context, state) {
          if (state is! ParaPharmaSearchFilterChanged) {}
          return ParaMedicalFiltersView();
        },
      ),
    );
  }
}
