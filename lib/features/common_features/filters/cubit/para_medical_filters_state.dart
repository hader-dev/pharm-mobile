part of 'para_medical_filters_cubit.dart';


sealed class ParaMedicalFiltersState {}

final class ParaMedicalFiltersStateInitial extends ParaMedicalFiltersState {}

final class ParaMedicalFiltersIsLoading extends ParaMedicalFiltersState {}

final class ParaMedicalFiltersLoaded extends ParaMedicalFiltersState {}

final class ParaMedicalFiltersLoadingError extends ParaMedicalFiltersState {}

final class ParaMedicalFiltersPageChanged extends ParaMedicalFiltersState {}

final class ParaMedicalFiltersUpdated extends ParaMedicalFiltersState {}
