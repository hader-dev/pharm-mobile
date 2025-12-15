part of 'para_pharm_filters_cubit.dart';

sealed class ParaPharmFiltersState {
  const ParaPharmFiltersState();
}

final class ParaPharmFiltersInitial extends ParaPharmFiltersState {}

final class ParaPharmFiltersChanged extends ParaPharmFiltersState {}

final class ParaPharmFiltersBrandSearchLoading extends ParaPharmFiltersState {}

final class ParaPharmFiltersBrandSearchLoaded extends ParaPharmFiltersState {}

final class ParaPharmFiltersBrandSearchLoadingFailed extends ParaPharmFiltersState {}

final class ParaPharmFiltersCategorySearchLoading extends ParaPharmFiltersState {}

final class ParaPharmFiltersCategorySearchLoaded extends ParaPharmFiltersState {}

final class ParaPharmFiltersCategorySearchLoadingFailed extends ParaPharmFiltersState {}
