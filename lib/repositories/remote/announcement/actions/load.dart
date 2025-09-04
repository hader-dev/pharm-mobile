import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/mappers/json_to_announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadAnnouncements> loadAnnouncements(INetworkService client,
    {int limit = 20, int offset = 0, String? companyId, String? search}) async {
  final queryParams = {
    'limit': limit.toString(),
    'offset': offset.toString(),
    if (companyId != null) 'filters[companyId]': companyId,
  };

  if (search != null && search.isNotEmpty) {
    queryParams['search[title]'] = search;
  }

  try {
    var decodedResponse = await client.sendRequest(() => client.get(
          Urls.announcements,
          queryParams: queryParams,
        ));

    final response = jsonToAnnouncementsResponse(decodedResponse);

    return response;
  } catch (e) {
    if (search != null && search.isNotEmpty) {
      return ResponseLoadAnnouncements(announcements: [], totalItems: 0);
    }
    rethrow;
  }
}
