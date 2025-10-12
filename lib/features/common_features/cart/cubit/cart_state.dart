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

  CartState(
      {required this.totalHtAmount,
      required this.totalTTCAmount,
      required this.selectedPaymentMethod,
      required this.selectedInvoiceType,
      required this.orderNote,
      required this.shippingAddress,
      required this.cartItems,
      required this.cartItemsByVendor});

  CartState copyWith({
    num? totalHtAmount,
    num? totalTTCAmount,
    PaymentMethods? selectedPaymentMethod,
    InvoiceTypes? selectedInvoiceType,
    String? orderNote,
    String? shippingAddress,
    List<CartItemModelUi>? cartItems,
    Map<String, List<String>>? cartItemsByVendor,
  }) {
    return CartState(
      totalHtAmount: totalHtAmount ?? this.totalHtAmount,
      totalTTCAmount: totalTTCAmount ?? this.totalTTCAmount,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      selectedInvoiceType: selectedInvoiceType ?? this.selectedInvoiceType,
      orderNote: orderNote ?? this.orderNote,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      cartItems: cartItems ?? this.cartItems,
      cartItemsByVendor: cartItemsByVendor ?? this.cartItemsByVendor,
    );
  }

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

  CartInitial initial(CartState state) => CartInitial.fromState(state: state);

  CartLoading loading() => CartLoading.fromState(state: this);

  CartLoadingUpdate loadingUpdate() => CartLoadingUpdate.fromState(this);

  CartLoadingSuccess loadingSuccess({
    required List<CartItemModelUi> cartItems,
    required Map<String, List<String>> cartItemsByVendor,
  }) =>
      CartLoadingSuccess.fromState(copyWith(
        cartItems: cartItems,
        cartItemsByVendor: cartItemsByVendor,
      ));

  CartError cartError({required String error}) =>
      CartError.fromState(state: this, error: error);

  CartItemUpdated itemUpdated(
      {required CartItemModelUi updatedItem, bool removed = false}) {
    if (removed) {
      final updatedItems = cartItems
          .where((item) => item.model.id != updatedItem.model.id)
          .toList();

      final updatedItemsByVendor = cartItemsByVendor.map((key, value) {
        return MapEntry(
          key,
          value.where((id) => id != updatedItem.model.id).toList(),
        );
      });

      return CartItemUpdated.fromState(
          state: this,
          cartItems: updatedItems,
          cartItemsByVendor: updatedItemsByVendor);
    }

    final updatedItems = cartItems.map((item) {
      if (item.model.id == updatedItem.model.id) {
        return updatedItem;
      }
      return item;
    }).toList();

    return CartItemUpdated.fromState(
      state: this,
      cartItems: updatedItems,
    );
  }

  PassOrderLoaded passOrderSuccess() {
    return PassOrderLoaded.fromState(this);
  }

  PassOrderLoadingFailed passOrderError() {
    return PassOrderLoadingFailed.fromState(this);
  }

  CartItemAdded cartItemAdded() {
    return CartItemAdded.fromState(this);
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
        );
}

final class CartLoading extends CartInitial {
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
        );
}

final class CartLoadingUpdate extends CartInitial {
  CartLoadingUpdate.fromState(CartState state)
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

final class CartLoadingSuccess extends CartInitial {
  CartLoadingSuccess.fromState(CartState state)
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

final class CartItemUpdated extends CartInitial {
  CartItemUpdated.fromState(
      {required CartState state,
      required super.cartItems,
      Map<String, List<String>>? cartItemsByVendor})
      : super(
            totalHtAmount: CartState.calculateTotalAmountHt(cartItems),
            totalTTCAmount: CartState.calculateTotalAmountTtc(cartItems),
            selectedPaymentMethod: state.selectedPaymentMethod,
            selectedInvoiceType: state.selectedInvoiceType,
            orderNote: state.orderNote,
            shippingAddress: state.shippingAddress,
            cartItemsByVendor: cartItemsByVendor ?? state.cartItemsByVendor);
}

final class CartItemsUpdated extends CartInitial {
  CartItemsUpdated.fromState(CartState state)
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

final class AddCartItemLoading extends CartInitial {
  AddCartItemLoading.fromState(CartState state)
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

final class CartLoadLimitReached extends CartInitial {
  CartLoadLimitReached.fromState(CartState state)
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

final class InvoiceTypeChanged extends CartInitial {
  InvoiceTypeChanged.fromState(CartState state)
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

final class PaymentMethodChanged extends CartInitial {
  PaymentMethodChanged.fromState(CartState state)
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

final class PassOrderLoading extends CartInitial {
  PassOrderLoading.fromState(CartState state)
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

final class PassOrderLoaded extends CartInitial {
  PassOrderLoaded.fromState(CartState state)
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

final class PassOrderLoadingFailed extends CartInitial {
  PassOrderLoadingFailed.fromState(CartState state)
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

final class CartItemAdded extends CartInitial {
  CartItemAdded.fromState(CartState state)
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

final class CartError extends CartInitial {
  final String error;

  CartError({required this.error});

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
        );
}
