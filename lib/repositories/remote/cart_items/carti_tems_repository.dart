import '../../../models/cart_items_response.dart';
import '../../../models/create_cart_item.dart';

abstract class ICartItemsRepository {
  Future<CartItemsResponse> getCartItem();
  Future<void> deleteItem(String id);
  Future<void> removeAll();
  Future<void> updateItem(String id, Map<String, dynamic> cartItem);
  Future<void> addCartItem(CreateCartItemModel cartItem);
}
