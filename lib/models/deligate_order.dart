import 'package:hader_pharm_mobile/models/order_details.dart';
import 'package:hader_pharm_mobile/models/para_pharma.dart';

class DeligateParahparmOrderItem {
  final bool isParapharm;
  final BaseParaPharmaCatalogModel product;
  final int quantity;
  final double? suggestedPrice;

  DeligateParahparmOrderItem({
    required this.isParapharm,
    required this.product,
    required this.quantity,
    this.suggestedPrice,
  });

  DeligateParahparmOrderItem copyWith({
    int? quantity,
    double? suggestedPrice,
  }) {
    return DeligateParahparmOrderItem(
      isParapharm: isParapharm,
      product: product,
      quantity: quantity ?? this.quantity,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}

class DeligateOrderItem {
  final bool isParapharm;
  final OrderItem product;
  final int quantity;
  final double? suggestedPrice;

  DeligateOrderItem({
    required this.isParapharm,
    required this.product,
    required this.quantity,
    this.suggestedPrice,
  });

  DeligateOrderItem copyWith({
    int? quantity,
    double? suggestedPrice,
  }) {
    return DeligateOrderItem(
      isParapharm: isParapharm,
      product: product,
      quantity: quantity ?? this.quantity,
      suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    );
  }
}
