//import '../../../model/person.dart';

import 'dart:convert';

import '../../../models/promotion.dart' show PromotionModel;
import '../../../utils/assets_strings.dart';
import '../../../utils/data_loader_helper.dart';
import 'promotion_repository.dart';

class PromotionRepository extends IPromotionRepository {
  @override
  Future<List<PromotionModel>> getPromotions() async {
    var data = jsonDecode(await DataLoaderHelper.loadDummyData(JsonAssetStrings.promotionsJson));
    return (data as List).map((promo) => PromotionModel.fromJson(promo)).toList();
  }
}
