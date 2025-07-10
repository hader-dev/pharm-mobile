//import '../../../model/person.dart';

import '../../../models/announcement.dart';

abstract class IPromotionRepository {
  Future<List<AnnouncementModel>> getPromotions();
}
