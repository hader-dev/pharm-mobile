import 'dart:convert';
import 'package:hader_pharm_mobile/repositories/remote/announcement/mappers/json_to_announcement.dart';
import 'package:hader_pharm_mobile/repositories/remote/announcement/response/response_load_announcements.dart';
import 'package:hader_pharm_mobile/utils/assets_strings.dart';
import 'package:hader_pharm_mobile/utils/data_loader_helper.dart';

Future<ResponseLoadAnnouncements> loadDummyAnnouncements() async {
  var data = jsonDecode(
      await DataLoaderHelper.loadDummyData(JsonAssetStrings.promotionsJson));
  var parsedList =
      jsonToAnnouncementsList(data);

  return ResponseLoadAnnouncements(announcements: parsedList);
}
