import '../../../models/product.dart';
import '../../../models/productDetails.dart';

abstract class IProductRepository {
  Future<List<Product>> getProducts({
    String? category,
    String? search,
    String? brand,
    required int limit,
    required int offset,
    int? categoryId,
    int? brandsId,
  });
  Future<ProductDetailsModel> getProductById({required int id});
}
