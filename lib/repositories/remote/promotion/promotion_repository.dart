//import '../../../model/person.dart';


import '../../../models/promotion.dart';

abstract class IPromotionRepository {
  Future<List<PromotionModel>> getPromotions();
}
