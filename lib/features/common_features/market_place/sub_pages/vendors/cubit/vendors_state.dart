part of 'vendors_cubit.dart';

sealed class VendorsState {}

final class VendorsInitial extends VendorsState {}

final class VendorsLoading extends VendorsState {}

final class VendorsLoadingMore extends VendorsState {}

final class VendorsLoaded extends VendorsState {}

final class VendorsLoadingFailed extends VendorsState {}

final class VendorsLoadLimitReached extends VendorsState {}

final class VendorSearchFilterChanged extends VendorsState {}
