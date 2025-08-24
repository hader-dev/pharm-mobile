import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_all_read.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseMarkAllRead> markAllRead(INetworkService client) async {
  await client.sendRequest(() => client.post(
        Urls.notificationMarkAllRead,
      ));

  return ResponseMarkAllRead();
}
