import 'package:http/src/response.dart';
import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/cart_item.dart';
import '../../../models/create_cart_item.dart';
import '../../../utils/urls.dart';
import 'carti_tems_repository.dart';

class CartItemRepository extends ICartItemsRepository {
  final NetworkManager client;
  CartItemRepository({required this.client});

  @override
  Future<List<CartItemModel>> getCartItem({offset = 0, limit = 10}) async {
    try {
      final Response response = await client.sendRequest(() => client.get(
            Urls.cartItem,
          ));
      var decodedResponse = ResponseHandler.processResponse(response);

      return (decodedResponse['data'] as List).map((prod) => CartItemModel.fromJson(prod)).toList();
    } catch (e) {
      print('Error reading JSON file: $e');
      return <CartItemModel>[];
    }
  }

  @override
  Future deleteItem(int id) {
    return client.sendRequest(() => client.delete(
          "${Urls.cartItem}/$id",
        ));
  }

  @override
  Future updateItem(int id, Map<String, dynamic> cartItem) {
    return client.sendRequest(() => client.patch(
          "${Urls.cartItem}/$id",
          payload: cartItem,
        ));
  }

  @override
  Future addItem(CreateCartItemModel cartItem) async {
    Response response = await client.sendRequest(() => client.post(
          Urls.cartItem,
          payload: cartItem.toMap(),
        ));
    ResponseHandler.processResponse(response);
  }

  @override
  Future removeAll(payload) async {
    return client.sendRequest(() => client.delete(
          Urls.cartItemBulkRemove,
          payload: payload,
        ));
  }
}
