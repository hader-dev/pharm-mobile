import 'dart:convert';

import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/config/services/notification/mappers/json_to_notification_model.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/mappers/json_to_notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notification_one.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/data_loader_helper.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadNotificationOne> loadOneNotification(
    ParamsLoadNotification params, INetworkService client) async {
  var decodedResponse = await client.sendRequest(() => client.get(
        Urls.notifications,
      ));

  var parsed = jsonToNotification(decodedResponse);

  return ResponseLoadNotificationOne(data: parsed);
}

Future<NotificationModel> mockResponse(
    ParamsLoadNotifications params, INetworkService client) async {
  var data = jsonDecode(
      await DataLoaderHelper.loadDummyData(JsonAssetStrings.notificationsJson));

  return jsonToNotificationModel(data[0]);
}
