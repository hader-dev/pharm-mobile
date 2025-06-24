import 'package:hader_pharm_mobile/models/order.dart';

class OrderResponse {
  final int totalItems;
  final List<OrderModel> data;

  OrderResponse({required this.totalItems, required this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      totalItems: json["totalItems"] ?? 0,
      data: (json["data"] as List).map((e) => OrderModel.fromJson(e)).toList(),
    );
  }
}
