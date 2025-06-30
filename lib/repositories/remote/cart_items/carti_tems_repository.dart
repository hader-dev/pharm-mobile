import '../../../models/cart_items_response.dart';
import '../../../models/create_cart_item.dart';

abstract class ICartItemsRepository {
  Future<CartItemsResponse> getCartItem();
  Future deleteItem(String id);
  Future removeAll(payload);
  Future updateItem(String id, Map<String, dynamic> cartItem);
  Future addCartItem(CreateCartItemModel cartItem);
}
