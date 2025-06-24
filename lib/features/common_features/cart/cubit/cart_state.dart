part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartInitial {}

final class CartLoadingUpdate extends CartInitial {}

final class CartLoadingSuccess extends CartInitial {}

final class CartQuantityUpdated extends CartInitial {}

final class SingleCartItemRemoved extends CartInitial {}

final class NewCartItemAdded extends CartInitial {}

final class AllItemsRemoved extends CartInitial {}

final class AllItemsSelected extends CartInitial {}

final class AllItemsUnSelected extends CartInitial {}

final class CartError extends CartInitial {
  final String error;
  CartError({required this.error});
}
