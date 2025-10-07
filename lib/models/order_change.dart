import 'package:hader_pharm_mobile/models/deligate_order.dart';

class OrderItemDelete {
  final String id;
  final DeligateOrderItem item;
  const OrderItemDelete({required this.id, required this.item});
}

class OrderItemChange {
  final String id;
  final int quantity;
  final double? price;

  OrderItemChange({required this.id, this.price, required this.quantity});

  OrderItemChange copyWith({
    int? quantity,
    double? price,
  }) {
    return OrderItemChange(
        id: id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
    };
  }
}

class OrderItemAdd {
  final String productId;
  final int quantity;
  final bool isParapharm;
  final double price;

  OrderItemAdd(
      {required this.productId,
      required this.quantity,
      required this.price,
      this.isParapharm = true});

  OrderItemAdd copyWith({
    int? quantity,
    double? price,
  }) {
    return OrderItemAdd(
      productId: productId,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (isParapharm) 'parapharmCatalogId': productId,
      if (!isParapharm) 'medicineCatalogId': productId,
      'quantity': quantity,
    };
  }
}

class OrderChangeModel {
  List<OrderItemDelete> deleteOrderItems = [];
  List<OrderItemChange> updateOrderItems = [];
  List<OrderItemAdd> addOrderItems = [];

  Map<String, dynamic> toJson() {
    return {
      'deleteOrderItems': deleteOrderItems.map((el) => el.id).toList(),
      'updateOrderItems': updateOrderItems.map((el) => el.toJson()).toList(),
      'addOrderItems': addOrderItems.map((el) => el.toJson()).toList(),
    };
  }

  bool get isDirty =>
      deleteOrderItems.isNotEmpty ||
      updateOrderItems.isNotEmpty ||
      addOrderItems.isNotEmpty;

  void removeOrderItem(DeligateOrderItem item) {
    final isNewItem = addOrderItems.indexWhere((el) =>
            el.productId == item.product.parapharmCatalogId ||
            el.productId == item.product.medicineCatalogId) ==
        -1;

    if (isNewItem) {
      addOrderItems.removeWhere((el) => el.productId == item.product.id);
      return;
    }

    deleteOrderItems.add(OrderItemDelete(id: item.product.id, item: item));
  }

  void updateOrderItem(DeligateOrderItem item) {
    final existsIndex =
        updateOrderItems.indexWhere((el) => el.id == item.product.id);

    if (existsIndex != -1) {
      updateOrderItems[existsIndex] = OrderItemChange(
          id: item.product.id,
          quantity: item.quantity,
          price: item.suggestedPrice);
      return;
    }

    final isNewItemIndex = addOrderItems.indexWhere((el) =>
        el.productId == item.product.parapharmCatalogId ||
        el.productId == item.product.medicineCatalogId);

    if (isNewItemIndex != -1) {
      addOrderItems[isNewItemIndex] = addOrderItems[isNewItemIndex].copyWith(
        quantity: item.quantity,
        price: item.suggestedPrice,
      );
      return;
    }

    updateOrderItems.add(OrderItemChange(
        id: item.product.id,
        quantity: item.quantity,
        price: item.suggestedPrice));
  }

  void reset() {
    deleteOrderItems = [];
    updateOrderItems = [];
    addOrderItems = [];
  }

  void addOrderItem(DeligateOrderItem newOrderItem) {
    addOrderItems.add(
      OrderItemAdd(
          productId: newOrderItem.isParapharm
              ? newOrderItem.product.parapharmCatalogId!
              : newOrderItem.product.medicineCatalogId!,
          price:
              newOrderItem.suggestedPrice ?? newOrderItem.product.unitPriceHt,
          quantity: newOrderItem.quantity),
    );
  }
}
