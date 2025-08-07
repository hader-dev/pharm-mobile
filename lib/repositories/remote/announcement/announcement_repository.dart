import 'package:hader_pharm_mobile/repositories/remote/announcement/params/load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

abstract class IPromotionRepository {
  Future<ResponseLoadAnnouncements> getPromotions();
  Future<ResponseLoadAnnouncementDetails> getPromotion(ParamsLoadAnnouncementDetails params);
}
