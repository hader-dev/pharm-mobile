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
  final CartItemRepository cartItemRepository;
  final OrderRepository ordersRepository;
  final ScrollController scrollController;
  Timer? _debounce;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CartCubit({
    required this.cartItemRepository,
    required this.scrollController,
    required this.ordersRepository,
    String shippingAddress = '',
  }) : super(CartInitial(
          shippingAddress: shippingAddress,
        ));

  Future<void> addToCart(CreateCartItemModel cartItem,
      [bool isParapharma = false]) async {
    try {
      emit(state.loading());

      final existingItem = getItemIfExists(cartItem.productId, isParapharma);

      if (existingItem != null) {
        final updatedItem = {"quantity": cartItem.quantity};

        await cartItemRepository.updateItem(existingItem.model.id, updatedItem);
      } else {
        await cartItemRepository.addCartItem(cartItem);
      }

      getCartItem();
      emit(state.cartItemAdded());
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
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
      emit(state.loading());

      CartItemsResponse response = await cartItemRepository.getCartItem();
      final cartItems = cartItemModelDataToUi(response.data);
      final cartItemsByVendor =
          await prepareOrderCartitemsByVendor(response.data);

      emit(state.loadingSuccess(
        cartItems: cartItems,
        cartItemsByVendor: cartItemsByVendor,
      ));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("$e");
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
  }

  void decreaseCartPackageQuantity(CartItemModelUi item) {
    try {
      if (item.model.quantity <= 1) {
        throw TemplateException(
            message: "quantity should be greater than or equal 1.");
      }

      final updatedItem = item.copyWith(quantity: item.model.quantity - 1);
      _debounceFunction(() async {
        applyUpdateItemQuantity(item.model.id, updatedItem.model.quantity);
      });
      emit(state.itemUpdated(updatedItem: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void increaseCartPackageQuantity(CartItemModelUi item) {
    try {
      if ((item.model.medicinesCatalogId != null &&
              item.model.quantity == item.model.medicineCatalogStockQty) ||
          (item.model.parapharmCatalogId != null &&
              item.model.quantity == item.model.parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      final updatedQuantity =
          int.parse(item.packageQuantityController.text) + 1;
      final updatedPackageQuantity = updatedQuantity ~/ item.model.packageSize;

      final updatedItem = item.copyWith(quantity: updatedQuantity);

      item.packageQuantityController.text = updatedPackageQuantity.toString();
      item.quantityController.text = updatedQuantity.toString();

      _debounceFunction(() async {
        applyUpdateItemQuantity(
            updatedItem.model.id, updatedItem.model.quantity);
      });

      emit(state.itemUpdated(updatedItem: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
  }

  void decreaseCartItemQuantity(CartItemModelUi item) {
    try {
      if (item.model.quantity <= 1) {
        throw TemplateException(
            message: "quantity should be greater than or equal 1.");
      }

      final updatedQuantity =
          int.parse(item.packageQuantityController.text) - 1;
      final updatedPackageQuantity = updatedQuantity ~/ item.model.packageSize;

      final updatedItem = item.copyWith(quantity: updatedQuantity);

      item.packageQuantityController.text = updatedPackageQuantity.toString();
      item.quantityController.text = updatedQuantity.toString();

      _debounceFunction(() async {
        applyUpdateItemQuantity(item.model.id, updatedItem.model.quantity);
      });
      emit(state.itemUpdated(updatedItem: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
    }
  }

  void updateCartItemInputQuantity(CartItemModelUi item, int quantity) {
    _debounceFunction(() async {
      try {
        final updatedItem = item.copyWith(quantity: quantity);
        applyUpdateItemQuantity(item.model.id, updatedItem.model.quantity);
        emit(state.itemUpdated(updatedItem: updatedItem));
      } catch (e) {
        GlobalExceptionHandler.handle(exception: e);
      }
    }, 500);
  }

  void increaseCartItemQuantity(CartItemModelUi item) {
    try {
      if ((item.model.medicinesCatalogId != null &&
              item.model.quantity == item.model.medicineCatalogStockQty) ||
          (item.model.parapharmCatalogId != null &&
              item.model.quantity == item.model.parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      final updatedQuantity = item.model.quantity + 1;
      final updatedPackageQuantity = updatedQuantity ~/ item.model.packageSize;

      final updatedItem = item.copyWith(quantity: updatedQuantity);

      item.packageQuantityController.text = updatedPackageQuantity.toString();
      item.quantityController.text = updatedQuantity.toString();

      _debounceFunction(() async {
        applyUpdateItemQuantity(
            updatedItem.model.id, updatedItem.model.quantity);
      });

      emit(state.itemUpdated(updatedItem: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
  }

  void decreaseCartItemPackageQuantity(CartItemModelUi item) {
    final cartItem = item.model;

    final updatedPackageQuantity =
        cartItem.packageQuantity > 1 ? cartItem.packageQuantity - 1 : 1;
    final updatedQuantity = updatedPackageQuantity * cartItem.packageSize;

    final updatedItem = item.copyWith(quantity: updatedQuantity);

    item.packageQuantityController.text = updatedPackageQuantity.toString();
    item.quantityController.text = updatedQuantity.toString();

    _debounceFunction(() async {
      applyUpdateItemQuantity(updatedItem.model.id, updatedItem.model.quantity);
    });
    emit(state.itemUpdated(updatedItem: updatedItem));
  }

  void increaseCartItemPackageQuantity(CartItemModelUi item) {
    try {
      if ((item.model.medicinesCatalogId != null &&
              item.model.quantity == item.model.medicineCatalogStockQty) ||
          (item.model.parapharmCatalogId != null &&
              item.model.quantity == item.model.parapharmCatalogStockQty)) {
        throw TemplateException(message: "you reached the limit of the stock.");
      }

      final updatedPackageQuantity =
          int.parse(item.packageQuantityController.text) + 1;

      final updatedQuantity = updatedPackageQuantity * item.model.packageSize;

      item.packageQuantityController.text = updatedPackageQuantity.toString();
      item.quantityController.text = updatedQuantity.toString();

      final updatedItem = item.copyWith(quantity: updatedQuantity);

      _debounceFunction(() async {
        applyUpdateItemQuantity(item.model.id, updatedItem.model.quantity);
      });
      emit(state.itemUpdated(updatedItem: updatedItem));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
  }

  deleteCartItem(CartItemModelUi item) async {
    try {
      await cartItemRepository.deleteItem(item.model.id);

      emit(state.itemUpdated(updatedItem: item, removed: true));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
  }

  Future<void> applyUpdateItemQuantity(String cartItemId, int quantity) async {
    try {
      await cartItemRepository.updateItem(cartItemId, {"quantity": quantity});
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: e.toString()));
    }
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
    emit(state.initial(state.copyWith(selectedInvoiceType: invoiceType)));
  }

  void changePaymentMethod(PaymentMethods paymentMethod) {
    emit(state.initial(state.copyWith(selectedPaymentMethod: paymentMethod)));
  }

  Future<bool> passOrder() async {
    if (formKey.currentState?.validate() == false) return false;

    try {
      emit(state.loading());

      await Future.wait(state.cartItemsByVendor.keys.map((sellerId) async {
        return ordersRepository.createOrder(
            orderDetails: CreateOrderModel(
          deliveryAddress: state.shippingAddress,
          deliveryTownId: 10,
          sellerCompanyId: sellerId,
          cartItemsIds: state.cartItemsByVendor[sellerId] ?? [],
          clientNote: state.orderNote,
        ));
      }));

      emit(state.passOrderSuccess());
      return true;
    } catch (e, stack) {
      debugPrint("$e");
      debugPrintStack(stackTrace: stack);
      emit(state.passOrderError());
      return false;
    }
  }

  changeOrderNote(String text) {
    emit(
      state.initial(state.copyWith(orderNote: text)),
    );
  }

  void clearCart(AppLocalizations translation) async {
    try {
      await cartItemRepository.removeAll();
      emit(state.loadingSuccess(
        cartItems: [],
        cartItemsByVendor: {},
      ));
    } catch (e) {
      GlobalExceptionHandler.handle(exception: e);
      emit(state.cartError(error: translation.feedback_error_loading_cart));
    }
  }

  CartItemModelUi? getItemIfExists(String id, [bool isParapharma = false]) {
    final existingItem = state.cartItems
        .where((element) => isParapharma
            ? element.model.parapharmCatalogId == id
            : element.model.medicinesCatalogId == id)
        .firstOrNull;

    return existingItem;
  }

  void updateShippingAddress(String value) {
    emit(state.initial(state.copyWith(shippingAddress: value)));
  }

  void updateItemPackageQuantity(CartItemModelUi item) {
    final updatedQuantity =
        int.parse(item.packageQuantityController.text) * item.model.packageSize;

    item.quantityController.text = updatedQuantity.toString();

    final updatedItem = item.copyWith(quantity: updatedQuantity);

    emit(state.itemUpdated(updatedItem: updatedItem));
  }

  void updateItemQuantity(CartItemModelUi item) {
    final quantity = int.parse(item.quantityController.text);
    final updatedItem = item.copyWith(quantity: quantity);

    updatedItem.packageQuantityController.text =
        (quantity ~/ updatedItem.model.packageSize).toString();

    emit(state.itemUpdated(updatedItem: updatedItem));
  }
}
