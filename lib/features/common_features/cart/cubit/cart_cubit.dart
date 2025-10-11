import 'dart:async' show Timer;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/cart_items/cart_items_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/cart_items/response/cart_items_response.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/exceptions.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  num totalHtAmount = 0;
  num totalTTCAmount = 0;
  Timer? _debounce;
  PaymentMethods selectedPaymentMethod = PaymentMethods.cash;
  InvoiceTypes? selectedInvoiceType = InvoiceTypes.facture;
  String orderNote = '';
  String shippingAddress;
  List<CartItemModelUi> cartItems = <CartItemModelUi>[];
  Map<String, List<String>> cartItemsByVendor = {};

  final CartItemRepository cartItemRepository;
  final OrderRepository ordersRepository;
  final ScrollController scrollController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CartCubit({
    required this.cartItemRepository,
    required this.scrollController,
    required this.ordersRepository,
    this.shippingAddress = '',
  }) : super(CartInitial());

  Future<void> addToCart(CreateCartItemModel cartItem,
      [bool isParapharma = false]) async {
    try {
      emit(AddCartItemLoading());

      final existingItem = getItemIfExists(cartItem.productId, isParapharma);

      if (existingItem != null) {
        final updatedItem = {"quantity": cartItem.quantity};

        await cartItemRepository.updateItem(existingItem.model.id, updatedItem);
      } else {
        await cartItemRepository.addCartItem(cartItem);
      }

      getCartItem();
      emit(CartItemAdded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  Future<Map<String, List<String>>> prepareOrderCartitemsByVendor(
      List<CartItemModel> cartItems) async {
    var reslutMap = <String, List<String>>{};
    await Future.forEach(
      cartItems,
      (item) {
        if (reslutMap.containsKey(item.sellerCompany.id)) {
          reslutMap[item.sellerCompany.id]!.add(item.id);
        } else {
          reslutMap[item.sellerCompany.id] = [item.id];
        }
      },
    );
    return reslutMap;
  }

  Future<void> getCartItem() async {
    try {
      cartItems = <CartItemModelUi>[];
      cartItemsByVendor = {};

      emit(CartLoading());

      CartItemsResponse response = await cartItemRepository.getCartItem();
      cartItems = cartItemModelDataToUi(response.data);
      cartItemsByVendor = await prepareOrderCartitemsByVendor(response.data);

      updateTotals();

      emit(CartLoadingSuccess());
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("$e");
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  void decreaseCartPackageQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.model.id == cartItemId);
      if (cartItems[cartItemIndex].model.quantity <= 1) {
        throw TemplateException(
            message: "quantity should be greater than or equal 1.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].model.quantity - 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].model.quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void increaseCartPackageQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.model.id == cartItemId);
      if ((cartItems[cartItemIndex].model.medicinesCatalogId != null &&
              cartItems[cartItemIndex].model.quantity ==
                  cartItems[cartItemIndex].model.medicineCatalogStockQty) ||
          (cartItems[cartItemIndex].model.parapharmCatalogId != null &&
              cartItems[cartItemIndex].model.quantity ==
                  cartItems[cartItemIndex].model.parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].model.quantity + 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].model.quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  void decreaseCartItemQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.model.id == cartItemId);
      if (cartItems[cartItemIndex].model.quantity <= 1) {
        throw TemplateException(
            message: "quantity should be greater than or equal 1.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].model.quantity - 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].model.quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void updateCartItemInputQuantity(String cartItemId, int quantity) {
    _debounceFunction(() async {
      try {
        int cartItemIndex = cartItems
            .lastIndexWhere((element) => element.model.id == cartItemId);

        cartItems[cartItemIndex] =
            cartItems[cartItemIndex].copyWith(quantity: quantity);
        updateTotals();
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].model.quantity);
        emit(CartQuantityUpdated(updatedItemId: cartItemId));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }, 500);
  }

  void increaseCartItemQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.model.id == cartItemId);
      if ((cartItems[cartItemIndex].model.medicinesCatalogId != null &&
              cartItems[cartItemIndex].model.quantity ==
                  cartItems[cartItemIndex].model.medicineCatalogStockQty) ||
          (cartItems[cartItemIndex].model.parapharmCatalogId != null &&
              cartItems[cartItemIndex].model.quantity ==
                  cartItems[cartItemIndex].model.parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].model.quantity + 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].model.quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  void decreaseCartItemPackageQuantity(String id) {
    final cartItemIndex =
        cartItems.indexWhere((element) => element.model.id == id);
    final cartItem = cartItems[cartItemIndex].model;

    final updatedPackageQuantity =
        cartItem.packageQuantity > 1 ? cartItem.packageQuantity - 1 : 1;
    final updatedQuantity = updatedPackageQuantity * cartItem.packageSize;

    cartItems[cartItemIndex] =
        cartItems[cartItemIndex].copyWith(quantity: updatedQuantity);

    updateTotals();
    _debounceFunction(() async {
      updateItemQuantity(id, cartItems[cartItemIndex].model.quantity);
    });
    emit(CartQuantityUpdated(updatedItemId: id));
  }

  void increaseCartItemPackageQuantity(String id) {
    final cartItemIndex =
        cartItems.indexWhere((element) => element.model.id == id);
    final cartItem = cartItems[cartItemIndex];

    final updatedPackageQuantity = cartItem.model.packageQuantity + 1;
    final updatedQuantity = updatedPackageQuantity * cartItem.model.packageSize;

    cartItems[cartItemIndex] =
        cartItems[cartItemIndex].copyWith(quantity: updatedQuantity);

    updateTotals();
    _debounceFunction(() async {
      updateItemQuantity(id, cartItems[cartItemIndex].model.quantity);
    });
    emit(CartQuantityUpdated(updatedItemId: id));
  }

  deleteCartItem(String cartItemId) async {
    try {
      await cartItemRepository.deleteItem(cartItemId);
      cartItems.removeWhere((element) => element.model.id == cartItemId);
      cartItemsByVendor =
          await prepareOrderCartitemsByVendor(cartItemModelUiToData(cartItems));
      updateTotals();
      emit(CartLoadingSuccess());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> updateItemQuantity(String cartItemId, int quantity) async {
    try {
      await cartItemRepository.updateItem(cartItemId, {"quantity": quantity});
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  updateTotals() {
    totalHtAmount = calculateTotalAmountHt(cartItems);
    totalTTCAmount = calculateTotalAmountTtc(cartItems);
  }

  num calculateTotalAmountTtc(List<CartItemModelUi> cartItems) {
    double totalAmount = 0;
    for (var element in cartItems) {
      totalAmount += element.model.getTotalPrice()["totalTTCPrice"]!;
    }
    return totalAmount;
  }

  num calculateTotalAmountHt(List<CartItemModelUi> cartItems) {
    num totalAmount = 0;
    for (var element in cartItems) {
      totalAmount += element.model.getTotalPrice()["totalHtPrice"]!;
    }
    return totalAmount;
  }

  Future<void> _debounceFunction(Future<void> Function() func,
      [int milliseconds = 500]) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () async {
      await func();
      _debounce = null;
    });
  }

  void changeInvoiceType(InvoiceTypes invoiceType) {
    selectedInvoiceType = invoiceType;
    emit(InvoiceTypeChanged());
  }

  void changePaymentMethod(PaymentMethods paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    emit(PaymentMethodChanged());
  }

  Future<bool> passOrder() async {
    if (formKey.currentState?.validate() == false) return false;

    try {
      emit(PassOrderLoading());

      await Future.wait(cartItemsByVendor.keys.map((sellerId) async {
        return ordersRepository.createOrder(
            orderDetails: CreateOrderModel(
          deliveryAddress: shippingAddress,
          deliveryTownId: 10,
          sellerCompanyId: sellerId,
          cartItemsIds: cartItemsByVendor[sellerId] ?? [],
          clientNote: orderNote,
        ));
      }));

      emit(PassOrderLoaded());
      return true;
    } catch (e, stack) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stack);
      emit(PassOrderLoadingFailed());
      return false;
    }
  }

  changeOrderNote(String text) {
    orderNote = text;
  }

  void clearCart(AppLocalizations translation) async {
    try {
      cartItems.clear();
      cartItemsByVendor.clear();
      updateTotals();
      await cartItemRepository.removeAll();
      emit(CartLoadingSuccess());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: translation.feedback_error_loading_cart));
    }
  }

  CartItemModelUi? getItemIfExists(String id, [bool isParapharma = false]) {
    final existingItem = cartItems
        .where((element) => isParapharma
            ? element.model.parapharmCatalogId == id
            : element.model.medicinesCatalogId == id)
        .firstOrNull;

    return existingItem;
  }

  void updateShippingAddress(String value) {
    shippingAddress = value;
  }

  void updateItemPackageQuantity(String id, int parse) {}
}
