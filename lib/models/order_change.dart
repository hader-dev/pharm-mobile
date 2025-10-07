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

  OrderItemAdd(
      {required this.productId,
      required this.quantity,
      this.isParapharm = true});

  OrderItemAdd copyWith({
    int? quantity,
  }) {
    return OrderItemAdd(
        productId: productId, quantity: quantity ?? this.quantity);
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
}
