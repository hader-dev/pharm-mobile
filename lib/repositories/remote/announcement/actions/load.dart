import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/mappers/json_to_announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadAnnouncements> loadAnnouncements(
    INetworkService client) async {
  
  var decodedResponse = await client.sendRequest(() => client.get(
        Urls.announcements,
      ));

  var parsedList =
      jsonToAnnouncementsList(decodedResponse);

  return ResponseLoadAnnouncements(announcements: parsedList);
}
