part of 'orders_details_cubit.dart';

sealed class OrdersDetailsState {}

final class OrdersInitial extends OrdersDetailsState {}

// Orders products states

final class OrderDetailsLoading extends OrdersDetailsState {}

final class OrderDetailsLoaded extends OrdersDetailsState {}

final class OrderDetailsLoadingFailed extends OrdersDetailsState {}
