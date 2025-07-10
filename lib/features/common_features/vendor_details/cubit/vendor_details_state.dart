part of 'vendor_details_cubit.dart';

sealed class VendorDetailsState {}

final class VendorDetailsInitial extends VendorDetailsState {}

final class VendorDetailsLoading extends VendorDetailsState {}

final class VendorDetailsLoaded extends VendorDetailsState {}

final class VendorDetailsLoadingError extends VendorDetailsState {}

//request to join vendor as client
final class SendingJoinRequest extends VendorDetailsState {}

final class JoinRequestSent extends VendorDetailsState {}

final class VendorLiked extends VendorDetailsState {}

final class VendorLikeFailed extends VendorDetailsState {}
