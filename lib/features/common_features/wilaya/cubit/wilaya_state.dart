part of 'wilaya_cubit.dart';

sealed class WilayaState {}

final class WilayaStateInitial extends WilayaState {}

final class WilayaIsLoading extends WilayaState {}

final class WilayaLoaded extends WilayaState {}

final class WilayaLoadingError extends WilayaState {}


final class TownlsLoading extends WilayaState {}

final class TownLoaded extends WilayaState {}

final class TownLoadingError extends WilayaState {}
