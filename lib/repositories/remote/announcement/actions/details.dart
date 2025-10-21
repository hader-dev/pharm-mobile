import 'package:flutter/widgets.dart';
import 'package:hader_pharm_mobile/config/services/network/network_interface.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/mappers/json_to_announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/params/load_announcement_details.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcement_details.dart';
import 'package:hader_pharm_mobile/utils/urls.dart';

Future<ResponseLoadAnnouncementDetails> loadAnnouncementDetails(
    INetworkService client, ParamsLoadAnnouncementDetails params) async {
  var decodedResponse = await client.sendRequest(() => client.get(
        "${Urls.announcements}/${params.id}",
      ));

  try {
    return jsonToAnnouncementDetailsResponse(decodedResponse);
  } catch (e, stackTrace) {
    debugPrint("$e");
    debugPrintStack(stackTrace: stackTrace);

    return ResponseLoadAnnouncementDetails(
      medicines: [],
      parapharmas: [],
    );
  }
}
