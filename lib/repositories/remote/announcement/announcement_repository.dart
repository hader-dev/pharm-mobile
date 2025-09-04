import 'package:hader_pharm_mobile/repositories/remote/announcement/params/load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

abstract class IPromotionRepository {
  Future<ResponseLoadAnnouncements> getPromotions({int limit = 20, int offset = 0, String? companyId, String? search});
  Future<ResponseLoadAnnouncementDetails> getPromotion(ParamsLoadAnnouncementDetails params);
}
