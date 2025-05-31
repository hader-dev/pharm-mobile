import '../../../models/cart_item.dart';
import '../../../models/create_cart_item.dart';

abstract class ICartItemsRepository {
  Future<List<CartItemModel>> getCartItem();
  Future deleteItem(int id);
  Future removeAll(payload);
  Future updateItem(int id, Map<String, dynamic> cartItem);
  Future addItem(CreateCartItemModel cartItem);
}
