part of 'medicine_details_cubit.dart';

sealed class MedicineDetailsState {}

final class MedicineDetailsInitial extends MedicineDetailsState {}

final class MedicineDetailsLoading extends MedicineDetailsState {}

final class MedicineDetailsLoaded extends MedicineDetailsState {}

final class MedicineDetailsLoadError extends MedicineDetailsState {}

final class MedicineDetailsTapIndexChanged extends MedicineDetailsState {}

final class MedicineQuantityChanged extends MedicineDetailsState {}
