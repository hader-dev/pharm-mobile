import 'package:hader_pharm_mobile/models/cart_item.dart' show CartItemModel;

import 'response/cart_items_response.dart';
import '../../../models/create_cart_item.dart';

abstract class ICartItemsRepository {
  Future<CartItemsResponse> getCartItem();
  Future<void> deleteItem(String id);
  Future<void> removeAll();
  Future<CartItemModel> updateItem(String id, Map<String, dynamic> cartItem);
  Future<void> addCartItem(CreateCartItemModel cartItem);
}
