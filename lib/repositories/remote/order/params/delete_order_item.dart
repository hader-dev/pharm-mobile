class ParamsDeleteOrderItem {
  final String itemId;
  final String orderId;
  ParamsDeleteOrderItem({required this.orderId, required this.itemId});

  Map<String, dynamic> toJson() {
    return {
      "deleteOrderItem": [itemId]
    };
  }
}
