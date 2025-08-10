part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class LoadingMoreOrders extends OrdersState {}

final class OrdersLoaded extends OrdersState {}

final class OrdersLoadingFailed extends OrdersState {}

final class OrdersLoadLimitReached extends OrdersState {}