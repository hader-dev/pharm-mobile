
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/actions/load.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';

import 'announcement_repository.dart';

class PromotionRepository extends IPromotionRepository {
  final INetworkService client;
  PromotionRepository({required this.client});
  @override
  Future<ResponseLoadAnnouncements> getPromotions() async {
    
    return loadAnnouncements(client);
  }
}
