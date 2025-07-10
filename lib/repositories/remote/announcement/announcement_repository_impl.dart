//import '../../../model/person.dart';

import 'dart:convert';

import '../../../config/services/network/network_interface.dart';
import '../../../models/announcement.dart';
import '../../../utils/assets_strings.dart';
import '../../../utils/data_loader_helper.dart';
import 'announcement_repository.dart';

class PromotionRepository extends IPromotionRepository {
  final INetworkService client;
  PromotionRepository({required this.client});
  @override
  Future<List<AnnouncementModel>> getPromotions() async {
    var data = jsonDecode(await DataLoaderHelper.loadDummyData(JsonAssetStrings.promotionsJson));
    return (data as List).map((promo) => AnnouncementModel.fromJson(promo)).toList();
  }
}
