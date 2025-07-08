part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartInitial {}

final class CartLoadingUpdate extends CartInitial {}

final class CartLoadingSuccess extends CartInitial {}

final class CartQuantityUpdated extends CartInitial {
  final String updatedItemId;

  CartQuantityUpdated({required this.updatedItemId});
}

final class SingleCartItemRemoved extends CartInitial {}

final class NewCartItemAdded extends CartInitial {}

final class AllItemsRemoved extends CartInitial {}

final class AllItemsSelected extends CartInitial {}

final class AllItemsUnSelected extends CartInitial {}

final class AddCartItemLoading extends CartInitial {}

final class CartItemAdded extends CartInitial {}

final class CartLoadLimitReached extends CartInitial {}

final class InvoiceTypeChanged extends CartInitial {}

final class PaymentMethodChanged extends CartInitial {}

final class PassOrderLoading extends CartInitial {}

final class PassOrderLoaded extends CartInitial {}

final class PassOrderLoadingFailed extends CartInitial {}

final class CartError extends CartInitial {
  final String error;
  CartError({required this.error});
}
