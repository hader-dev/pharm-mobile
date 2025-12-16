import 'dart:convert' show jsonEncode;

import 'package:flutter/foundation.dart';
import 'package:hader_pharm_mobile/models/cart_item.dart' show CartItemModel;

import '../../../config/services/network/network_interface.dart';
import '../../../models/create_cart_item.dart';
import '../../../utils/urls.dart';
import 'carti_tems_repository.dart';
import 'response/cart_items_response.dart';

class CartItemRepository extends ICartItemsRepository {
  final INetworkService client;
  CartItemRepository({required this.client});

  @override
  Future<CartItemsResponse> getCartItem({int offset = 0, int limit = 10}) async {
    try {
      var decodedResponse = await client.sendRequest(() => client.get(
            Urls.cartItems,
            queryParams: {
              "include[sellerCompany][fields][]": ["id", "name"],
              "include[parapharmCatalog][_load]": jsonEncode(true),
              "include[medicineCatalog][_load]": jsonEncode(true),
            },
          ));

      return CartItemsResponse.fromJson(decodedResponse);
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("$e");
      return CartItemsResponse(data: []);
    }
  }

  @override
  Future<void> deleteItem(String id) {
    return client.sendRequest(() => client.delete(
          "${Urls.cartItems}/$id",
        ));
  }

  @override
  Future<CartItemModel> updateItem(String id, Map<String, dynamic> cartItem) async {
    var decodedResponse = await client.sendRequest(() => client.patch(
          "${Urls.cartItems}/$id",
          payload: cartItem,
        ));
    return CartItemModel.fromJson(decodedResponse);
  }

  @override
  Future<void> addCartItem(CreateCartItemModel cartItem) async {
    await client.sendRequest(() => client.post(
          Urls.cartItems,
          payload: cartItem.toMap(),
        ));
  }

  @override
  Future<void> removeAll() async {
    await client.sendRequest(() => client.delete(
          Urls.removeAllCartItems,
        ));
  }
}
