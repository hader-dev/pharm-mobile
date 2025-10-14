part of 'vendor_details_cubit.dart';

sealed class VendorDetailsState {
  final Company vendor;

  VendorDetailsState({required this.vendor});

  VendorDetailsLoading toLoading() => VendorDetailsLoading.fromState(
        state: this,
      );

  VendorDetailsLoaded toLoaded({
    required Company vendor,
  }) =>
      VendorDetailsLoaded.fromState(
        state: this,
        vendor: vendor,
      );

  VendorDetailsLoadingError toError() => VendorDetailsLoadingError.fromState(
        state: this,
      );

  SendingJoinRequest toSendingJoinRequest() => SendingJoinRequest.fromState(
        state: this,
      );

  JoinRequestSent toJoinRequestSent() => JoinRequestSent.fromState(
        state: this,
      );

  VendorLiked toVendorLiked() => VendorLiked.fromState(
        state: this,
      );

  VendorLikeFailed toVendorLikeFailed() => VendorLikeFailed.fromState(
        state: this,
      );
}

final class VendorDetailsInitial extends VendorDetailsState {
  VendorDetailsInitial({
    Company? vendor,
  }) : super(vendor: vendor ?? Company.empty());
}

final class VendorDetailsLoading extends VendorDetailsState {
  VendorDetailsLoading.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}

final class VendorDetailsLoaded extends VendorDetailsState {
  VendorDetailsLoaded.fromState({
    required VendorDetailsState state,
    required super.vendor,
  });
}

final class VendorDetailsLoadingError extends VendorDetailsState {
  VendorDetailsLoadingError.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}

//request to join vendor as client
final class SendingJoinRequest extends VendorDetailsState {
  SendingJoinRequest.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}

final class JoinRequestSent extends VendorDetailsState {
  JoinRequestSent.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}

final class VendorLiked extends VendorDetailsState {
  VendorLiked.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}

final class VendorLikeFailed extends VendorDetailsState {
  VendorLikeFailed.fromState({
    required VendorDetailsState state,
  }) : super(vendor: state.vendor);
}
