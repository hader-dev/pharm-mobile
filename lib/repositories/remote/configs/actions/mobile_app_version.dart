import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/models/mobile_app_version.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/mappers/json_to_mobile_app_version.dart';
import 'package:hader_pharm_mobile/repositories/remote/configs/params/mobile_app_version.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<MobileAppVersion> getAvaillableAppUpdate(
    INetworkService client, ParamsMobileAppVersion params) async {
  try {
    var decodedResponse = await client.sendRequest(() => client
            .get(Urls.mobileAppVersion, queryParams: {
          if (params.myAppVersion != null) "myVersion": params.myAppVersion!
        }));

    return jsonToMobileAppVersion(decodedResponse);
  } catch (e, stacktrace) {
    debugPrintStack(stackTrace: stacktrace);
    debugPrint("$e");
    return MobileAppVersion(
      url: "",
      isUpdateAvaillable: false,
      version: "latest",
    );
  }
}
