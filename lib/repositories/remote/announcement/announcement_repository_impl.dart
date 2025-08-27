import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/actions/details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/actions/load.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/params/load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

import 'announcement_repository.dart';

class PromotionRepository extends IPromotionRepository {
  final INetworkService client;
  PromotionRepository({required this.client});
  @override
  Future<ResponseLoadAnnouncements> getPromotions(
      {int limit = 20, int offset = 0, String? companyId}) async {
    return loadAnnouncements(client,
        limit: limit, offset: offset, companyId: companyId);
  }

  @override
  Future<ResponseLoadAnnouncementDetails> getPromotion(
      ParamsLoadAnnouncementDetails params) async {
    return loadAnnouncementDetails(client, params);
  }
}
