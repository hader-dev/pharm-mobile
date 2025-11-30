part of 'cart_cubit.dart';

class CartState {
  final num totalHtAmount;
  final num totalTTCAmount;
  final PaymentMethods selectedPaymentMethod;
  final InvoiceTypes selectedInvoiceType;
  final String orderNote;
  final String shippingAddress;
  final List<CartItemModelUi> cartItems;
  final Map<String, List<String>> cartItemsByVendor;
  final bool isCartSummaryExpanded;

  CartState(
      {required this.totalHtAmount,
      required this.totalTTCAmount,
      required this.selectedPaymentMethod,
      required this.selectedInvoiceType,
      required this.orderNote,
      required this.shippingAddress,
      required this.cartItems,
      required this.isCartSummaryExpanded,
      required this.cartItemsByVendor});

  static num calculateTotalAmountTtc(List<CartItemModelUi> items) {
    double totalAmount = 0;
    for (var element in items) {
      totalAmount += element.model.getTotalPrice()["totalTTCPrice"]!;
    }
    return totalAmount;
  }

  static num calculateTotalAmountHt(List<CartItemModelUi> items) {
    num totalAmount = 0;
    for (var element in items) {
      totalAmount += element.model.getTotalPrice()["totalHtPrice"]!;
    }
    return totalAmount;
  }

  CartInitial toInitial({required CartState state}) => CartInitial.fromState(state: state);
  ToggleCartSummary toToggleCartSummary({required bool isCartSummaryExpanded}) =>
      ToggleCartSummary.fromState(state: this, isCartSummaryExpanded: isCartSummaryExpanded);
  CartOrderInfosUpdated toOrderInfosUpdated(
          {String? orderNote,
          String? shippingAddress,
          PaymentMethods? selectedPaymentMethod,
          InvoiceTypes? selectedInvoiceType}) =>
      CartOrderInfosUpdated.fromState(
          state: this,
          orderNote: orderNote,
          shippingAddress: shippingAddress,
          selectedPaymentMethod: selectedPaymentMethod,
          selectedInvoiceType: selectedInvoiceType);

  CartLoading toLoading() => CartLoading.fromState(state: this);

  CartLoadingUpdate toLoadingUpdate() => CartLoadingUpdate.fromState(state: this);

  CartLoadingSuccess toLoadingSuccess({
    required List<CartItemModelUi> cartItems,
    required Map<String, List<String>> cartItemsByVendor,
  }) =>
      CartLoadingSuccess.fromState(
        state: this,
        cartItems: cartItems,
        cartItemsByVendor: cartItemsByVendor,
        totalHtAmount: calculateTotalAmountHt(cartItems),
        totalTTCAmount: calculateTotalAmountTtc(cartItems),
      );

  CartError toError({required String error}) => CartError.fromState(state: this, error: error);

  CartItemUpdated toItemUpdated({required CartItemModelUi updatedItem, bool removed = false}) {
    if (removed) {
      final updatedItems = cartItems.where((item) => item.model.id != updatedItem.model.id).toList();

      final updatedItemsByVendor = cartItemsByVendor.map((key, value) {
        return MapEntry(
          key,
          value.where((id) => id != updatedItem.model.id).toList(),
        );
      });

      return CartItemUpdated.fromState(state: this, cartItems: updatedItems, cartItemsByVendor: updatedItemsByVendor);
    }

    final List<CartItemModelUi> updatedItems = cartItems.map((item) {
      if (item.model.id == updatedItem.model.id) {
        item = updatedItem;
      }
      return item;
    }).toList();
    return CartItemUpdated.fromState(
      state: this,
      cartItems: updatedItems,
    );
  }

  PassOrderLoaded toPassOrderSuccess() {
    return PassOrderLoaded.fromState(state: this);
  }

  PassOrderLoadingFailed toPassOrderError() {
    return PassOrderLoadingFailed.fromState(state: this);
  }

  CartItemAdded toCartItemAdded() {
    return CartItemAdded.fromState(state: this);
  }
}

final class CartInitial extends CartState {
  CartInitial(
      {super.totalHtAmount = 0,
      super.totalTTCAmount = 0,
      super.selectedPaymentMethod = PaymentMethods.cash,
      super.selectedInvoiceType = InvoiceTypes.facture,
      super.orderNote = '',
      super.shippingAddress = '',
      super.isCartSummaryExpanded = true,
      super.cartItems = const [],
      super.cartItemsByVendor = const {}});

  CartInitial.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartLoading extends CartState {
  CartLoading.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class ToggleCartSummary extends CartState {
  ToggleCartSummary.fromState({required CartState state, required super.isCartSummaryExpanded})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
        );
}

final class CartOrderInfosUpdated extends CartState {
  CartOrderInfosUpdated.fromState(
      {required CartState state,
      String? orderNote,
      String? shippingAddress,
      PaymentMethods? selectedPaymentMethod,
      InvoiceTypes? selectedInvoiceType})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: selectedPaymentMethod ?? state.selectedPaymentMethod,
          selectedInvoiceType: selectedInvoiceType ?? state.selectedInvoiceType,
          orderNote: orderNote ?? state.orderNote,
          shippingAddress: shippingAddress ?? state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartLoadingUpdate extends CartState {
  CartLoadingUpdate.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartLoadingSuccess extends CartState {
  CartLoadingSuccess.fromState(
      {required CartState state,
      required super.cartItems,
      required super.cartItemsByVendor,
      required super.totalHtAmount,
      required super.totalTTCAmount})
      : super(
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartItemUpdated extends CartState {
  CartItemUpdated.fromState(
      {required CartState state, required super.cartItems, Map<String, List<String>>? cartItemsByVendor})
      : super(
            totalHtAmount: CartState.calculateTotalAmountHt(cartItems),
            totalTTCAmount: CartState.calculateTotalAmountTtc(cartItems),
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            isCartSummaryExpanded: state.isCartSummaryExpanded,
            cartItemsByVendor: cartItemsByVendor ?? state.cartItemsByVendor);
}

final class CartItemsUpdated extends CartState {
  CartItemsUpdated.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class AddCartItemLoading extends CartState {
  AddCartItemLoading.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartLoadLimitReached extends CartState {
  CartLoadLimitReached.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class InvoiceTypeChanged extends CartState {
  InvoiceTypeChanged.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class PaymentMethodChanged extends CartState {
  PaymentMethodChanged.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class PassOrderLoading extends CartState {
  PassOrderLoading.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class PassOrderLoaded extends CartState {
  PassOrderLoaded.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class PassOrderLoadingFailed extends CartState {
  PassOrderLoadingFailed.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartItemAdded extends CartState {
  CartItemAdded.fromState({required CartState state})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}

final class CartError extends CartState {
  final String error;

  CartError.fromState({required CartState state, required this.error})
      : super(
          totalHtAmount: state.totalHtAmount,
          totalTTCAmount: state.totalTTCAmount,
          selectedPaymentMethod: state.selectedPaymentMethod,
          selectedInvoiceType: state.selectedInvoiceType,
          orderNote: state.orderNote,
          shippingAddress: state.shippingAddress,
          cartItems: state.cartItems,
          cartItemsByVendor: state.cartItemsByVendor,
          isCartSummaryExpanded: state.isCartSummaryExpanded,
        );
}
