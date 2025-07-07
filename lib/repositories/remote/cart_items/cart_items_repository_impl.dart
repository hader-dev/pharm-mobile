import '../../../config/services/network/network_interface.dart';

import '../../../models/cart_items_response.dart';
import '../../../models/create_cart_item.dart';
import '../../../utils/urls.dart';
import 'carti_tems_repository.dart';

class CartItemRepository extends ICartItemsRepository {
  final INetworkService client;
  CartItemRepository({required this.client});

  @override
  Future<CartItemsResponse> getCartItem({offset = 0, limit = 10}) async {
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.cartItems,
          queryParams: {
            "include[sellerCompany][fields][]": ["id", "name", "thumbnailImage", "image"],
          },
        ));

    return CartItemsResponse.fromJson(decodedResponse);
  }

  @override
  Future<void> deleteItem(String id) {
    return client.sendRequest(() => client.delete(
          "${Urls.cartItems}/$id",
        ));
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> cartItem) {
    return client.sendRequest(() => client.patch(
          "${Urls.cartItems}/$id",
          payload: cartItem,
        ));
  }

  @override
  Future<void> addCartItem(CreateCartItemModel cartItem) async {
    await client.sendRequest(() => client.post(
          Urls.cartItems,
          payload: cartItem.toMap(),
        ));
  }

  @override
  Future<void> removeAll(payload) async {
    return client.sendRequest(() => client.delete(
          Urls.cartItemsBulkRemove,
          payload: payload,
        ));
  }
}
