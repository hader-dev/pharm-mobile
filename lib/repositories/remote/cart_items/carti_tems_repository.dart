import '../../../models/cart_items_response.dart';
import '../../../models/create_cart_item.dart';

abstract class ICartItemsRepository {
  Future<CartItemsResponse> getCartItem();
  Future deleteItem(int id);
  Future removeAll(payload);
  Future updateItem(int id, Map<String, dynamic> cartItem);
  Future addItem(CreateCartItemModel cartItem);
}
