import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/mobile_app_version.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/params/mobile_app_version.dart';

import 'actions/mobile_app_version.dart' as actions;
import 'config_repository.dart';

class ConfigRepository implements IConfigRepository {
  final INetworkService client;
  ConfigRepository({required this.client});

  @override
  Future<MobileAppVersion> getAvaillableAppUpdate(
      ParamsMobileAppVersion params) async {
    return actions.getAvaillableAppUpdate(client, params);
  }
}
