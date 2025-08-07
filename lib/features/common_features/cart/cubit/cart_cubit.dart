import 'dart:async' show Timer;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hader_pharm_mobile/config/language_config/resources/app_localizations.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart';
import 'package:hader_pharm_mobile/models/cart_items_response.dart';
import 'package:hader_pharm_mobile/models/create_cart_item.dart';
import 'package:hader_pharm_mobile/models/create_order_model.dart';
import 'package:hader_pharm_mobile/repositories/remote/cart_items/cart_items_repository_impl.dart';
import 'package:hader_pharm_mobile/repositories/remote/order/order_repository_impl.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/exceptions.dart';
import 'package:hader_pharm_mobile/utils/app_exceptions/global_expcetion_handler.dart';
import 'package:hader_pharm_mobile/utils/enums.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  num totalHtAmount = 0;
  num totalTTCAmount = 0;
  Timer? _debounce;
  PaymentMethods? selectedPaymentMethod;
  InvoiceTypes? selectedInvoiceType;
  String orderNote = '';
  String shippingAddress = '';
  // int totalItemsCount = 0;
  // int offSet = 0;
  List<CartItemModel> cartItems = <CartItemModel>[];
  Map<String, List<String>> cartItemsByVendor = {};

  final CartItemRepository cartItemRepository;
  final OrderRepository ordersRepository;
  final ScrollController scrollController;
  CartCubit(
      this.cartItemRepository, this.scrollController, this.ordersRepository)
      : super(CartInitial()) {
    _onScroll();
  }
  _onScroll() {
    // scrollController.addListener(() async {
    //   if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
    //     if (offSet < totalItemsCount) {
    //       //  await loadMoreOrders();
    //     } else {
    //       emit(CartLoadLimitReached());
    //     }
    //   }
    // });
  }

  Future<void> addToCart(CreateCartItemModel cartItem,
      [bool isParapharma = false]) async {
    try {
      emit(AddCartItemLoading());

      final existingItem = getItemIfExists(cartItem.productId, isParapharma);

      if (existingItem != null) {
        final updatedItem = {"quantity": cartItem.quantity};

        await cartItemRepository.updateItem(existingItem.id, updatedItem);
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
      cartItems = <CartItemModel>[];
      cartItemsByVendor = {};

      emit(CartLoading());

      CartItemsResponse response = await cartItemRepository.getCartItem();
      cartItems = response.data;
      cartItemsByVendor = await prepareOrderCartitemsByVendor(cartItems);

      updateTotals();

      emit(CartLoadingSuccess());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  void decreaseCartItemQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.id == cartItemId);
      if (cartItems[cartItemIndex].quantity <= 1) {
        throw TemplateException(
            message: "quantity should be greater than or equal 1.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].quantity - 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void increaseCartItemQuantity(String cartItemId) {
    try {
      int cartItemIndex =
          cartItems.lastIndexWhere((element) => element.id == cartItemId);
      if ((cartItems[cartItemIndex].medicinesCatalogId != null &&
              cartItems[cartItemIndex].quantity ==
                  cartItems[cartItemIndex].medicineCatalogStockQty) ||
          (cartItems[cartItemIndex].parapharmCatalogId != null &&
              cartItems[cartItemIndex].quantity ==
                  cartItems[cartItemIndex].parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      cartItems[cartItemIndex] = cartItems[cartItemIndex]
          .copyWith(quantity: cartItems[cartItemIndex].quantity + 1);
      updateTotals();
      _debounceFunction(() async {
        updateItemQuantity(cartItemId, cartItems[cartItemIndex].quantity);
      });
      emit(CartQuantityUpdated(updatedItemId: cartItemId));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(CartError(error: e.toString()));
    }
  }

  deleteCartItem(String cartItemId) async {
    try {
      await cartItemRepository.deleteItem(cartItemId);
      cartItems.removeWhere((element) => element.id == cartItemId);
      cartItemsByVendor = await prepareOrderCartitemsByVendor(cartItems);
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

  num calculateTotalAmountTtc(List<CartItemModel> cartItems) {
    double totalAmount = 0;
    for (var element in cartItems) {
      totalAmount += element.getTotalPrice()["totalTTCPrice"]!;
    }
    return totalAmount;
  }

  num calculateTotalAmountHt(List<CartItemModel> cartItems) {
    num totalAmount = 0;
    for (var element in cartItems) {
      totalAmount += element.getTotalPrice()["totalHtPrice"]!;
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

  passOrder() async {
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
    } catch (e) {
      emit(PassOrderLoadingFailed());
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

  CartItemModel? getItemIfExists(String id, [bool isParapharma = false]) {
    final existingItem = cartItems
        .where((element) => isParapharma
            ? element.parapharmCatalogId == id
            : element.medicinesCatalogId == id)
        .firstOrNull;

    return existingItem;
  }

  void updateShippingAddress(String value) {
    shippingAddress = value;
  }
}
