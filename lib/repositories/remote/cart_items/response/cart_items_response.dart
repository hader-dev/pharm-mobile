import 'package:hader_pharm_mobile/models/cart_item.dart';

class CartItemsResponse {
  final List<CartItemModel> data;

  CartItemsResponse({required this.data});

  factory CartItemsResponse.fromJson(List json) {
    return CartItemsResponse(
      data: json.map((e) => CartItemModel.fromJson(e)).toList(),
    );
  }
}
