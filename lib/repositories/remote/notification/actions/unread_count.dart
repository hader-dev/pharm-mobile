import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_unread_count.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseUnreadCount> loadNotificationsUnreadCount(
    INetworkService client) async {
  var decodedResponse = await client.sendRequest(() => client.get(
        Urls.notificationsUnreadCount,
      ));

  var count = decodedResponse is String
      ? int.tryParse(decodedResponse)
      : decodedResponse;
  return ResponseUnreadCount(unreadCount: count ?? 0);
}
