part of 'para_pharma_details_cubit.dart';

sealed class ParaPharmaDetailsState {}

final class ParaPharmaDetailsInitial extends ParaPharmaDetailsState {}

final class ParaPharmaDetailsLoading extends ParaPharmaDetailsState {}

final class ParaPharmaDetailsLoaded extends ParaPharmaDetailsState {}

final class ParaPharmaDetailsLoadError extends ParaPharmaDetailsState {}

final class ParaPharmaDetailsTapIndexChanged extends ParaPharmaDetailsState {}
