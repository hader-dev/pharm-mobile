import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_mark_read.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_mark_read.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseMarkRead> markRead(
    ParamsMarkRead params, INetworkService client) async {
  await client.sendRequest(() => client.post(
        Urls.notificationMarkRead(params.id),
      ));

  return ResponseMarkRead();
}
