import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import '../../../../models/cart_item.dart';
import '../../../../models/cart_items_response.dart';
import '../../../../repositories/remote/cart_items/cart_items_repository_impl.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartItemModel> cartItems = <CartItemModel>[];
  List<CartItemModel> selectedItems = <CartItemModel>[];
  bool selectAllBox = false;
  double total = 0;
  bool isSelectedMode = true;
  final CartItemRepository cartItemRepository;
  double totalHtAmount = 0;
  double totalTTCAmount = 0;
  CartCubit(this.cartItemRepository) : super(CartInitial());

  void isSelectedModeChanged() {
    isSelectedMode = !isSelectedMode;
    emit(CartLoadingSuccess());
  }

  void selectItem(CartItemModel cartItem) {
    if (selectedItems.contains(cartItem)) {
      unSelectItem(cartItem);
      return;
    }
    selectedItems.add(cartItem);
    totalAmount();
    emit(CartLoadingSuccess());
  }

  Future<void> getCartItem() async {
    try {
      cartItems = <CartItemModel>[];
      selectedItems = <CartItemModel>[];
      emit(CartLoading());

      CartItemsResponse response = await cartItemRepository.getCartItem();
      cartItems = response.data;

      selectedItems.addAll(cartItems);
      totalAmount();
      emit(CartLoadingSuccess());
    } catch (e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> removeArticle(int articleId) async {
    emit(CartLoadingUpdate());
    try {
      await cartItemRepository.deleteItem(articleId).then((_) {
        cartItems.removeWhere((element) => element.id == articleId);
        selectedItems.removeWhere((element) => element.id == articleId);
        totalAmount();
        emit(CartLoadingSuccess());
      });
    } catch (e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> removeAll() async {
    try {
      emit(CartLoadingUpdate());

      final ids = json.encode(selectedItems.map((e) => {"id": e.id}).toList());

      await cartItemRepository.removeAll(ids).then((_) {
        // Collect IDs to remove
        final idsToRemove = selectedItems.map((e) => e.id).toSet();
        cartItems.removeWhere((element) => idsToRemove.contains(element.id));
        selectedItems.clear();
        totalAmount();
        emit(CartLoadingSuccess());
      });
    } catch (e) {
      print(e.toString());
      print(cartItems.length.toString());

      emit(CartError(error: e.toString()));
    }
  }

  void updateCartItemQuantity(CartItemModel cartItem, int quantity) {
    emit(CartLoadingUpdate());
    try {
      cartItem.quantity = quantity;

      cartItemRepository.updateItem(cartItem.id!, {
        "quantity": cartItem.quantity,
      }).then((_) {
        totalAmount();
        emit(CartLoadingSuccess());
      });
    } catch (e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    }
  }

  void decreaseCartItemQuantity(CartItemModel cartItem) {
    if (cartItem.quantity > 1) {
      emit(CartLoadingUpdate());

      try {
        cartItem.quantity--;
        cartItemRepository.updateItem(cartItem.id!, {
          "quantity": cartItem.quantity,
        }).then((_) {
          totalAmount();
          emit(CartLoadingSuccess());
        });
      } catch (e) {
        print(e.toString());
        emit(CartError(error: e.toString()));
      }
    } else {
      totalAmount();
      emit(CartLoadingSuccess());
    }
  }

  void addNote({required int id, required String note}) {
    emit(CartLoadingUpdate());

    try {
      cartItemRepository.updateItem(id, {
        "note": note,
      }).then((_) {
        emit(CartLoadingSuccess());
      });
      cartItems.firstWhere((element) => element.id == id).note = note;
    } catch (e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    }
  }

  void addCartItem(CartItemModel cartItem) {
    emit(CartLoadingUpdate());
    try {
      cartItem.quantity++;
      cartItemRepository.updateItem(cartItem.id!, {
        "quantity": cartItem.quantity,
      }).then((_) {
        totalAmount();
        emit(CartLoadingSuccess());
      });
    } catch (e) {
      print(e.toString());
      emit(CartError(error: e.toString()));
    }
  }

  void totalAmount() {
    total = 0;
    totalHtAmount = 0;
    totalTTCAmount = 0;
    for (var item in selectedItems) {
      total += (double.parse(item.article!.price!) * double.parse(item.quantity.toString()));
    }
    for (CartItemModel item in selectedItems) {
      Map totals = item.getTotalPrice();
      double itemTotalHtPrice = totals["totalHtPrice"];
      double itemTotalTTCPrice = totals["totalTTCPrice"];
      totalHtAmount += itemTotalHtPrice;
      totalTTCAmount += itemTotalTTCPrice;
    }
    emit(CartLoadingSuccess());
  }

  double totalAmountOfSelectedItems() {
    total = 0;
    for (var item in selectedItems) {
      total += (double.parse(item.article!.price!) * double.parse(item.quantity.toString()));
    }
    totalAmount();
    return total;
  }

  void selectAll() {
    selectedItems = [];
    selectedItems.addAll(cartItems);
    totalAmount();
    emit(AllItemsSelected());
  }

  void unSelectAll() {
    selectedItems = [];
    totalHtAmount = 0;
    totalTTCAmount = 0;
    totalAmount();
    emit(AllItemsUnSelected());
  }

  void unSelectItem(CartItemModel cartItem) {
    selectedItems.removeWhere((element) => element.id == cartItem.id);
    totalAmount();
    emit(CartLoadingSuccess());
  }
}
