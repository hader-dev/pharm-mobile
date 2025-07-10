part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

// Orders products states

final class OrdersLoading extends OrdersState {}

final class LoadingMoreOrders extends OrdersState {}

final class OrdersLoaded extends OrdersState {}

final class OrdersLoadingFailed extends OrdersState {}

//Search Limit Reached State :
final class OrdersLoadLimitReached extends OrdersState {}

final class StatusFilterChanged extends OrdersState {}

final class PriceFilterChanged extends OrdersState {}

final class ResetFilters extends OrdersState {}

final class DateFilterChanged extends OrdersState {}
