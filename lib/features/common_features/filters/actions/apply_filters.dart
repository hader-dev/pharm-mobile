import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/medical/medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/filters/cubit/parapharm/para_medical_filters_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/medicine_products/cubit/medicine_products_cubit.dart';
import 'package:hader_pharm_mobile/features/common_features/market_place/sub_pages/para_pharma/cubit/para_pharma_cubit.dart';

void applyFiltersMedical(BuildContext context) {
  final appliedFilters = context.read<MedicalFiltersCubit>().appliedFilters;
  final medicineCatalogCubit = context.read<MedicineProductsCubit>();
  medicineCatalogCubit.updatedFilters(appliedFilters);
  medicineCatalogCubit.getMedicines(filters: appliedFilters);
}

void applyFiltersParaPharm(BuildContext context) {
  final appliedFilters = context.read<ParaMedicalFiltersCubit>().appliedFilters;
  final medicineCatalogCubit = context.read<ParaPharmaCubit>();
  medicineCatalogCubit.updatedFilters(appliedFilters);
  medicineCatalogCubit.getParaPharmas(filters: appliedFilters);
}
