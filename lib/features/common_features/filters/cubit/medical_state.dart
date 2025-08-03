part of 'medical_cubit.dart';

sealed class MedicalFiltersState {}

final class MedicalFiltersStateInitial extends MedicalFiltersState {}

final class MedicalFiltersIsLoading extends MedicalFiltersState {}

final class MedicalFiltersLoaded extends MedicalFiltersState {}

final class MedicalFiltersLoadingError extends MedicalFiltersState {}

