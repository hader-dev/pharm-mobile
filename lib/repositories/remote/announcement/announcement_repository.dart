import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

abstract class IPromotionRepository {
  Future<ResponseLoadAnnouncements> getPromotions();
}
