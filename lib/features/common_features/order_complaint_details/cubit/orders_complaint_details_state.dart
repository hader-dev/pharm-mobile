part of 'orders_complaint_details_cubit.dart';

sealed class OrdersComplaintState {}

final class OrdersComplaintsInitial extends OrdersComplaintState {}

// Orders products states

final class OrderComplaintsLoading extends OrdersComplaintState {}

final class OrderComplaintsLoaded extends OrdersComplaintState {}

final class OrderComplaintsLoadingFailed extends OrdersComplaintState {}
