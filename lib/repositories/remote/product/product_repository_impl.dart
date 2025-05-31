import '../../../config/services/network/network_manager.dart';
import '../../../config/services/network/network_response_handler.dart';
import '../../../models/product.dart';
import '../../../models/productDetails.dart';
import '../../../utils/urls.dart';
import 'product_repository.dart';

class ProductRepository extends IProductRepository {
  @override
  Future<List<Product>> getProducts(
      {String? category,
      String? search,
      String? brand,
      int? limit,
      int? offset,
      int? categoryId,
      int? brandsId,
      int? maxPrice,
      bool? inStockOnly,
      DateTime? startDate,
      DateTime? endDate,
      int? minPrice}) async {
    final queryParams = {
      ...{if (offset != null) 'offset': offset.toString()},
      ...{if (limit != null) 'limit': limit.toString()},
      'sortDirection': 'DESC',
    };

    if (categoryId != null) {
      queryParams['in[categoryId][]'] = categoryId.toString();
    }
    if (brandsId != null) {
      queryParams['in[brandId][]'] = brandsId.toString();
    }

    if (search != null && search.isNotEmpty) {
      queryParams['search[label]'] = search;
    }
    if (maxPrice != null) {
      queryParams['lt[maxPrice]'] = maxPrice.toString();
    }
    if (minPrice != null) {
      queryParams['gte[minPrice]'] = minPrice.toString();
    }

    if (inStockOnly != null) {
      queryParams['filters[isOutStock]'] = inStockOnly.toString();
    }
    if (startDate != null) {
      queryParams['fdate[createdAt][from]'] = startDate.toString();
    }
    if (endDate != null) {
      queryParams['date[createdAt][to]'] = endDate.toString();
    }

    final response = await NetworkManager.instance.sendRequest(() => NetworkManager.instance.get(
          Urls.product,
          queryParams: queryParams,
        ));
    var decodedResponse = ResponseHandler.processResponse(response);
    List<Product> products = (decodedResponse["data"] as List).map((item) => Product.fromJson(item)).toList();
    return products;
  }

  @override
  Future<ProductDetailsModel> getProductById({required int id}) async {
    final response = await NetworkManager.instance.sendRequest(() => NetworkManager.instance.get(
          "${Urls.product}/$id",
        ));
    var decodedResponse = ResponseHandler.processResponse(response);
    try {
      ProductDetailsModel.fromJson(decodedResponse);
    } catch (e) {
      print("Error in ProductDetailsModel.fromJson: $e");
    }

    return ProductDetailsModel.fromJson(decodedResponse);
  }
}
