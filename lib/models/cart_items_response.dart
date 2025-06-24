import 'cart_item.dart';

class CartItemsResponse {
  final int totalItems;
  final List<CartItemModel> data;

  CartItemsResponse({required this.totalItems, required this.data});

  factory CartItemsResponse.fromJson(Map<String, dynamic> json) {
    return CartItemsResponse(
      totalItems: json["totalItems"] ?? 0,
      data: (json["data"] as List).map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }
}
