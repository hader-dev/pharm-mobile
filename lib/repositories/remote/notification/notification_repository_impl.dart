import 'dart:convert';

import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/notification.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/params/params_load_notifications.dart';
import 'package:hader_pharm_mobile/repositories/remote/notification/responses/response_load_notifications.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/data_loader_helper.dart';

import 'notification_repository.dart';
import 'actions/load.dart' as load_actions;

class NotificationRepository extends INotificationRepository {

  final INetworkService client;

  NotificationRepository({required this.client});
  
  @override
  Future<NotificationModel> getNotificationById(int id) async {
    var data = jsonDecode(await DataLoaderHelper.loadDummyData(
        JsonAssetStrings.notificationsJson));
    return NotificationModel.fromJson(data[0]);
  }

  @override
  Future<ResponseLoadNotifications> getNotifications(ParamsLoadNotifications params) async {


    return load_actions.mockResponse(params, client);

  }

  @override
  Future<void> registerUserDevice(String deviceToken) {
    // TODO: implement registerUserDevice
    throw UnimplementedError();
  }
}
