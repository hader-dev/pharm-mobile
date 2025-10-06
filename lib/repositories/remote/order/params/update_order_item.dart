class ParamsUpdateOrderItem {
  final String orderId;
  final String itemId;
  final int? quantity;
  final double? price;

  ParamsUpdateOrderItem({
    required this.orderId,
    required this.itemId,
    this.quantity,
    this.price,
  }) : assert(price != null || quantity != null,
            'price or quantity must be not null');

  Map<String, dynamic> toJson() {
    return {
      'updateOrderItems': [
        {
          'id': itemId,
          if (quantity != null) 'quantity': quantity,
          if (price != null) 'price': price
        }
      ],
    };
  }
}
